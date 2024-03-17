// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8;

import {Test, console} from "forge-std/Test.sol";
import {HelloFirewall} from "../src/HelloFirewall.sol";

contract HelloFirewallTest is Test {
    HelloFirewall private helloFirewall;

    function setUp() public {
        helloFirewall = new HelloFirewall();
    }

    function test_Increment() public {
        helloFirewall.increment();
        assertEq(helloFirewall.number(), 1);
    }
}
