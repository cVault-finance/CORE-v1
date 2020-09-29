pragma solidity >=0.4.24 <0.7.0;

interface IFeeApprover {
    function setPaused(bool _pause) external;
    function setFeeMultiplier(uint8 _feeMultiplier) external;
    function setCoreVaultAddress(address _coreVaultAddress) external;
    function editNoFeeList(address _address, bool noFee) external;
    function setMinimumLiquidityToTriggerStop(uint finneyAmnt) external;
    function sync(uint8) external returns (bool lastIsMint, bool lpTokenBurn);
    function calculateAmountsAfterFee(        
        address sender, 
        address recipient,
        uint256 amount
        ) external  returns (uint256 transferToAmount, uint256 transferToFeeDistributorAmount);
}
