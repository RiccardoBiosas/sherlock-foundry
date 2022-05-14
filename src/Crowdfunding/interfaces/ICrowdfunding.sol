pragma solidity 0.8.4;

interface ICrowdfunding {
    function startCampaign() payable external;
    function getRefund(uint campaignID, uint funderID) external payable;
    function stopCampaign(uint campaignID) external payable;
}