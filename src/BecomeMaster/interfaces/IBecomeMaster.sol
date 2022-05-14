// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

interface IBecomeMaster {
    function allocate() external payable;

    function sendAllocation(address payable allocator) external;

    function takeMasterRole() external;

    function collectAllocations() external;

    function allocatorBalance(address allocator) external view;
}
