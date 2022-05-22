pragma solidity 0.8.4;

import "forge-std/Test.sol";
import "../CollisionExchange/target/CollisionExchangeChallenge.sol";
import "../CollisionExchange/exploit/CollisionExchangeExploit.sol";

contract CollisionExchangeTest is Test {
    CollisionExchangeChallenge public collisionExchangeChallenge;
    OrderBook public orderBook;
    CollisionExchangeExploit public collisionExchangeExploit;

    function setUp() public payable {
        orderBook = new OrderBook();

        orderBook.postTrade(address(this), 1000 wei);

        collisionExchangeChallenge = new CollisionExchangeChallenge(
            address(orderBook)
        );

        collisionExchangeChallenge.deposit{value: 1000 wei}();

        collisionExchangeExploit = new CollisionExchangeExploit(
            address(collisionExchangeChallenge)
        );
    }

    function testExploit() public payable {
        assertTrue(address(collisionExchangeChallenge).balance == 1000 wei);
        assertTrue(collisionExchangeChallenge.owner() == address(this));

        collisionExchangeExploit.exploit();

        assertTrue(
            collisionExchangeChallenge.owner() ==
                address(collisionExchangeExploit),
            "exploit failed"
        );
        assertTrue(
            address(collisionExchangeChallenge).balance == 0,
            "exploit failed"
        );
        assertTrue(
            address(collisionExchangeExploit).balance == 1000 wei,
            "exploit failed"
        );
    }
}
