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
    }

    address tokenUniswapPair;
    IUniswapV2Factory public uniswapFactory;
    address internal WETHAddress;
    address coreTokenAddress;
    address coreVaultAddress;
    uint8 public feePercentX100;  // max 255 = 25.5% artificial clamp
    uint256 public lastTotalSupplyOfLPTokens;
    bool paused;

    // CORE token is pausable 
    function setPaused(bool _pause) public onlyOwner {
        paused = _pause;
    }

    function setFeeMultiplier(uint8 _feeMultiplier) public onlyOwner {
        feePercentX100 = _feeMultiplier;
    }

    function setCoreVaultAddress(address _coreVaultAddress) public onlyOwner {
        coreVaultAddress = _coreVaultAddress;
    }

    function sync() public {
        uint256 _LPSupplyOfPairTotal = IERC20(tokenUniswapPair).totalSupply();
        lastTotalSupplyOfLPTokens = _LPSupplyOfPairTotal;
    }

    function calculateAmountsAfterFee(        
        address sender, 
        address recipient, // unusued maybe use din future
        uint256 amount
        ) public  returns (uint256 transferToAmount, uint256 transferToFeeDistributorAmount) 
        {
            require(paused == false, "FEE APPROVER: Transfers Paused");
            uint256 _LPSupplyOfPairTotal = IERC20(tokenUniswapPair).totalSupply();


            // console.log("sender is " , sender);
            // console.log("recipient is is " , recipient, 'pair is :', tokenUniswapPair);

            // console.log("Old LP supply", lastTotalSupplyOfLPTokens);
            // console.log("Current LP supply", _LPSupplyOfPairTotal);

            if(sender == tokenUniswapPair) 
                require(lastTotalSupplyOfLPTokens <= _LPSupplyOfPairTotal, "Liquidity withdrawals forbidden");
            
            // console.log('Sender is pair' , sender == tokenUniswapPair);
            // console.log('lastTotalSupplyOfLPTokens <= _LPSupplyOfPairTotal' , lastTotalSupplyOfLPTokens <= _LPSupplyOfPairTotal);

            if(sender == coreVaultAddress  || sender == tokenUniswapPair ) { // Dont have a fee when corevault is sending, or infinite loop
                console.log("Sending without fee");                       // And when pair is sending ( buys are happening, no tax on it)
                transferToFeeDistributorAmount = 0;
                transferToAmount = amount;
            } 
            else {
                console.log("Normal fee transfer");
                transferToFeeDistributorAmount = amount.mul(feePercentX100).div(1000);
                transferToAmount = amount.sub(transferToFeeDistributorAmount);
            }


           lastTotalSupplyOfLPTokens = _LPSupplyOfPairTotal;
        }


}
