pragma solidity 0.8.4;

import "forge-std/Test.sol";
import "../Crowdfunding/target/Crowdfunding.sol";
import "../Crowdfunding/exploit/CrowdfundingExploit.sol";

contract CrowdfundingTest is Test {
    Crowdfunding public crowdfunding;
    CrowdfundingExploit public crowdfundingExploit;

    function setUp() public {
        crowdfunding = new Crowdfunding{value: 1 wei}();
        crowdfundingExploit = new CrowdfundingExploit(address(crowdfunding));
    }

    function testExploit() public {
        assertTrue(address(crowdfunding).balance > 0);
        crowdfundingExploit.exploit{value: 1 wei}();
        assertTrue(address(crowdfunding).balance == 0, "exploit failed");
    }
}
