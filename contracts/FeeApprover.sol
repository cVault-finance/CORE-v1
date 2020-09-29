// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;
import "@openzeppelin/contracts-ethereum-package/contracts/access/Ownable.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/IERC20.sol"; // for WETH
import "@nomiclabs/buidler/console.sol";
import '@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol';
import "@openzeppelin/contracts-ethereum-package/contracts/Initializable.sol";

contract FeeApprover is OwnableUpgradeSafe {
    using SafeMath for uint256;

    function initialize(
        address _COREAddress,
        address _WETHAddress,
        address _uniswapFactory
    ) public initializer {
        OwnableUpgradeSafe.__Ownable_init();
        coreTokenAddress = _COREAddress;
        WETHAddress = _WETHAddress;
        tokenUniswapPair = IUniswapV2Factory(_uniswapFactory).getPair(WETHAddress,coreTokenAddress);
        feePercentX100 = 10;
        paused = true; // We start paused until sync post LGE happens.
        _editNoFeeList(0xC5cacb708425961594B63eC171f4df27a9c0d8c9, true); // corevault proxy
        _editNoFeeList(tokenUniswapPair, true);
        sync();
        minFinney = 5000;
    }


    address tokenUniswapPair;
    IUniswapV2Factory public uniswapFactory;
    address internal WETHAddress;
    address coreTokenAddress;
    address coreVaultAddress;
    uint8 public feePercentX100;  // max 255 = 25.5% artificial clamp
    uint256 public lastTotalSupplyOfLPTokens;
    bool paused;
    uint256 private lastSupplyOfCoreInPair;
    uint256 private lastSupplyOfWETHInPair;
    mapping (address => bool) public noFeeList;

    // CORE token is pausable 
    function setPaused(bool _pause) public onlyOwner {
        paused = _pause;
        sync();
    }

    function setFeeMultiplier(uint8 _feeMultiplier) public onlyOwner {
        feePercentX100 = _feeMultiplier;
    }

    function setCoreVaultAddress(address _coreVaultAddress) public onlyOwner {
        coreVaultAddress = _coreVaultAddress;
        noFeeList[coreVaultAddress] = true;
    }

    function editNoFeeList(address _address, bool noFee) public onlyOwner {
        _editNoFeeList(_address,noFee);
    }
    function _editNoFeeList(address _address, bool noFee) internal{
        noFeeList[_address] = noFee;
    }
    uint minFinney; // 2x for $ liq amount
    function setMinimumLiquidityToTriggerStop(uint finneyAmnt) public onlyOwner{ // 1000 = 1eth
        minFinney = finneyAmnt;
    }

    function sync() public returns (bool lastIsMint, bool lpTokenBurn) {

        // This will update the state of lastIsMint, when called publically
        // So we have to sync it before to the last LP token value.
        uint256 _LPSupplyOfPairTotal = IERC20(tokenUniswapPair).totalSupply();
        lpTokenBurn = lastTotalSupplyOfLPTokens > _LPSupplyOfPairTotal;
        lastTotalSupplyOfLPTokens = _LPSupplyOfPairTotal;

        uint256 _balanceWETH = IERC20(WETHAddress).balanceOf(tokenUniswapPair);
        uint256 _balanceCORE = IERC20(coreTokenAddress).balanceOf(tokenUniswapPair);

        // Do not block after small liq additions
        // you can only withdraw 350$ now with front running
        // And cant front run buys with liq add ( adversary drain )

        lastIsMint = _balanceCORE > lastSupplyOfCoreInPair && _balanceWETH > lastSupplyOfWETHInPair.add(minFinney.mul(1 finney));

        lastSupplyOfCoreInPair = _balanceCORE;
        lastSupplyOfWETHInPair = _balanceWETH;
    }


    function calculateAmountsAfterFee(        
        address sender, 
        address recipient, // unusued maybe use din future
        uint256 amount
        ) public  returns (uint256 transferToAmount, uint256 transferToFeeDistributorAmount) 
        {
            require(paused == false, "FEE APPROVER: Transfers Paused");
            (bool lastIsMint, bool lpTokenBurn) = sync();

            if(sender == tokenUniswapPair) {
                // This will block buys that are immidietly after a mint. Before sync is called/
                // Deployment of this should only happen after router deployment 
                // And addition of sync to all CoreVault transactions to remove 99.99% of the cases.
                require(lastIsMint == false, "Liquidity withdrawals forbidden");
                require(lpTokenBurn == false, "Liquidity withdrawals forbidden");
      
            }

            if(noFeeList[sender]) { // Dont have a fee when corevault is sending, or infinite loop
                console.log("Sending without fee");                       // And when pair is sending ( buys are happening, no tax on it)
                transferToFeeDistributorAmount = 0;
                transferToAmount = amount;
            } 
            else {
                console.log("Normal fee transfer");
                transferToFeeDistributorAmount = amount.mul(feePercentX100).div(1000);
                transferToAmount = amount.sub(transferToFeeDistributorAmount);
            }


        }


}
