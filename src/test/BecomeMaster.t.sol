pragma solidity 0.8.11;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import "../BecomeMaster/target/BecomeMaster.sol";
import "../BecomeMaster/exploit/BecomeMasterExploit.sol";

contract BecomeMasterTest is Test {
    BecomeMaster public becomeMaster;
    BecomeMasterExploit public becomeMasterExploit;

    address private ORIGINAL_MASTER;
    address private ORIGINAL_ADMIN;

    address ATTACKER = 0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045;

    function setUp() public payable {
        becomeMaster = new BecomeMaster{value: 0.001 ether}();
        becomeMasterExploit = new BecomeMasterExploit(address(becomeMaster));
        ORIGINAL_MASTER = becomeMaster.master();
        ORIGINAL_ADMIN = becomeMaster.admin();
        becomeMaster.allocate();
    }

    function testExploit() public payable {
        assertTrue(address(becomeMaster).balance == 0.001 ether);

        hoax(ATTACKER, 100 ether);
        becomeMasterExploit.exploit{value: 1 wei}();

        assertTrue(becomeMaster.master() != ORIGINAL_MASTER, "exploit failed");
        assertTrue(becomeMaster.admin() != ORIGINAL_ADMIN, "exploit failed");
        assertTrue(address(becomeMaster).balance == 0, "exploit failed");
    }
}
