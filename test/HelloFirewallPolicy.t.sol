// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8;

import {Test, console} from "forge-std/Test.sol";

import {Firewall} from "../src/firewall/Firewall.sol";

import {HelloFirewall} from "../src/HelloFirewall.sol";
import {HelloFirewallPolicy} from "../src/HelloFirewallPolicy.sol";

contract HelloFirewallPolicyTest is Test {
    Firewall firewall;

    HelloFirewall helloFirewall;
    HelloFirewallPolicy helloFirewallPolicy;

    function setUp() public {
        // Deploy a new firewall
        firewall = new Firewall();

        // Deploy our policy
        helloFirewallPolicy = new HelloFirewallPolicy();

        // Approve the policy on the firewall so that it can be used by consumers
        firewall.setPolicyStatus(address(helloFirewallPolicy), true);

        // Deploy our consumer
        helloFirewall = new HelloFirewall();

        // Configure the consumer to use the firewall
        helloFirewall.setFirewall(address(firewall));

        // Have the consumer globally subscribe to the policy
        firewall.addGlobalPolicy(address(helloFirewall), address(helloFirewallPolicy));
    }

    function test_HelloFirewallWorksWithTheFirewall() public {
        helloFirewall.increment();
        assertEq(helloFirewall.number(), 1);
    }

    function test_PolicyPreventsIncrementAboveThreshold() public {
        // Setup our initial state
        helloFirewall.increment();

        // Setup our expectation for the transaction to revert
        vm.expectRevert("Increment attempt exceeds threshold");

        // Try to increment again
        helloFirewall.increment();
    }

    function test_SetIncrementThreshold() public {
        // Set the threshold to 2
        helloFirewallPolicy.setIncrementThreshold(2);

        // Try to increment twice (should work this time)
        helloFirewall.increment();
        helloFirewall.increment();
        assertEq(helloFirewall.number(), 2);
    }
}
