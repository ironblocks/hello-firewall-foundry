// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8;

import {Script, console} from "forge-std/Script.sol";

import {Firewall} from "../src/firewall/Firewall.sol";

import {HelloFirewall} from "../src/HelloFirewall.sol";
import {HelloFirewallPolicy} from "../src/HelloFirewallPolicy.sol";

contract SetupEverything is Script {
    function run() public {
        vm.startBroadcast(vm.envUint("HF_PRIVATE_KEY"));

        // Deploy a new firewall
        Firewall firewall = new Firewall();
        console.log("Deployed Firewall to address: ", address(firewall));

        // Deploy our policy
        HelloFirewallPolicy helloFirewallPolicy = new HelloFirewallPolicy();
        console.log("Deployed HelloFirewallPolicy to address: ", address(helloFirewallPolicy));

        // Approve the policy on the firewall so that it can be used by consumers
        firewall.setPolicyStatus(address(helloFirewallPolicy), true);
        console.log("Approved HelloFirewallPolicy on Firewall!");

        // Deploy our consumer
        HelloFirewall helloFirewall = new HelloFirewall();
        console.log("Deployed HelloFirewall to address: ", address(helloFirewall));

        // Configure the firewall that protects the consumer
        helloFirewall.setFirewall(address(firewall));
        console.log("HelloFirewall is now using the Firewall!");

        // Have the consumer subscribe to the policy
        firewall.addGlobalPolicy(address(helloFirewall), address(helloFirewallPolicy));
        console.log("HelloFirewallPolicy was added to protect HelloFirewall!");

        vm.stopBroadcast();
    }
}
