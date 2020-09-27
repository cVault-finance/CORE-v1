pragma solidity 0.6.12;


import "./NBUNIERC20.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/GSN/Context.sol";
import "./INBUNIERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "./IFeeApprover.sol";
import "./ICoreVault.sol";
import "@nomiclabs/buidler/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol"; // for WETH
import "./uniswapv2/interfaces/IUniswapV2Factory.sol"; // interface factorys
import "./uniswapv2/interfaces/IUniswapV2Router02.sol"; // interface factorys
import '@uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol';
import "./uniswapv2/interfaces/IWETH.sol"; 
import "@openzeppelin/contracts-ethereum-package/contracts/access/Ownable.sol";

/// Please do not use this contract until its done, and tested.
/// Undefined behaviour might happen.
/// This code is shared/provided WITHOUT any warranties of any kind.

/// This contract is supposed to streamline liquidity additions
// By allowing people to put in any amount of ETH or CORE and get LP tokens back
contract COREv1Router {
    feeApprover public;
    /// Route 1 : Buy LP for ETH
    /// Route 2 : Buy LP for CORE

    // Function sell Core for ETH

    // Function wrap ETH

    // Function get price of CORE after sell

    // Function get amount of CORE with a ETH buy

    // Function get CORE needed to pair per ETH 

    // Function sync fee approver
    function sync() internal {
        feeApprover.sync();
    }

    // sets fee approver in case fee approver gets chaned.
    function setFeeApprover(address _feeApprover) onlyOwner public{
        feeApprover = IFeeApprover(_feeApprover);
    }

}