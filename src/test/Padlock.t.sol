pragma solidity 0.8.4;

import "forge-std/Test.sol";
import "../Padlock/target/PadlockChallenge.sol";
import "../Padlock/exploit/PadlockExploit.sol";

contract PadlockTest is Test {
    PadlockChallenge public padlockChallenge;
    PadlockExploit public padlockExploit;

    function setUp() public payable {
        string memory PIN = unicode"‮6167209‬";
        padlockChallenge = new PadlockChallenge(PIN);
        padlockExploit = new PadlockExploit(address(padlockChallenge));
    }

    function testExploit() public payable {
        assertTrue(padlockChallenge.opened() == false);

        padlockExploit.exploit{value: 33}();

        assertTrue(padlockChallenge.opened(), "exploit failed");
    }
}
