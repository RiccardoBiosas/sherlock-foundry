pragma solidity 0.8.4;

import "forge-std/Test.sol";
import "../ForceFeedingChallenge/target/ForceFeedingChallenge.sol";
import "../ForceFeedingChallenge/exploit/ForceFeedingChallengeExploit.sol";

contract ForceFeedingChallengeTest is Test {
    ForceFeedingChallenge public forceFeedingChallenge;
    ForceFeedingChallengeExploit public forceFeedingChallengeExploit;

    function setUp() public {
        forceFeedingChallenge = new ForceFeedingChallenge{value: 100 wei}();
        forceFeedingChallengeExploit = new ForceFeedingChallengeExploit(
            address(forceFeedingChallenge)
        );
    }

    function testExploit() public payable {
        uint256 exploitBalBefore = address(forceFeedingChallengeExploit).balance;
        assertTrue(address(forceFeedingChallenge).balance == 100 wei);

        forceFeedingChallengeExploit.exploit{value: 100 wei}();

        assertTrue(address(forceFeedingChallenge).balance == 0, "exploit failed");
        assertTrue(
            address(forceFeedingChallengeExploit).balance == exploitBalBefore + 200 wei, "exploit failed"
        );
    }
}
