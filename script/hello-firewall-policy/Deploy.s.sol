// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8;

import {Script, console} from "forge-std/Script.sol";

import {HelloFirewallPolicy} from "../../src/HelloFirewallPolicy.sol";

contract DeployHelloFirewallPolicy is Script {
    function run() public {
        vm.startBroadcast();

        HelloFirewallPolicy helloFirewall = new HelloFirewallPolicy();
        console.log("HelloFirewallPolicy Deployed to: ", address(helloFirewall));

        vm.stopBroadcast();
    }
}
