pragma solidity 0.6.12;

import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/IERC20.sol";


// Contract that sends tokens it gets to itself
// Making it generate fees with fee on transfer tokens
contract FeeGenerator {

    function transferToSelf(address tokenAddress, uint256 loopCount) public {
         for (uint256 counter = 0; counter < loopCount; ++counter) {
            IERC20(tokenAddress).transfer(address(this), IERC20(tokenAddress).balanceOf(address(this)));
        }
    }

}