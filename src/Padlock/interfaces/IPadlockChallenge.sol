pragma solidity 0.8.4;

interface IPadlockChallenge {
    function pick1(string memory passphrase) external;

    function pick2() external payable;

    function pick3(bytes16 message) external;

    function open() external;
}
