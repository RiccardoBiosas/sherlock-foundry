pragma solidity 0.8.4;

interface ICollisionExchangeChallenge {
    function deposit() external payable;

    function emergencyWithdraw() external payable;

    function postTrade(uint256 _amount) external;
}
