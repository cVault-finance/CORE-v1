pragma solidity 0.6.12;



import "./IFeeApprover.sol";

import "@openzeppelin/contracts-ethereum-package/contracts/access/Ownable.sol";

/// Please do not use this contract until its done, and tested.
/// Undefined behaviour might happen.
/// This code is shared/provided WITHOUT any warranties of any kind.

/// This contract is supposed to streamline liquidity additions
// By allowing people to put in any amount of ETH or CORE and get LP tokens back
contract COREv1Router is OwnableUpgradeSafe {
    IFeeApprover public _feeApprover;
    mapping (address => bool) public coreChosen;

    /// Route 1 : Buy LP for ETH
    /// Route 2 : Buy LP for CORE

    // Function sell Core for ETH

    // Function wrap ETH

    // Function get price of CORE after sell

    // Function get amount of CORE with a ETH buy

    // Function get CORE needed to pair per ETH 

    // Function sync fee approver
    function sync() public {
        _feeApprover.updateTxState();
    }

    // sets fee approver in case fee approver gets chaned.
    function setFeeApprover(address feeApproverAddress) onlyOwner public{
        _feeApprover = IFeeApprover(feeApproverAddress);
    }

}