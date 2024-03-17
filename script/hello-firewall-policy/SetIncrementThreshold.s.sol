// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8;

import {Script, console} from "forge-std/Script.sol";
import {HelloFirewallPolicy} from "../../src/HelloFirewallPolicy.sol";

contract SetFirewall is Script {
    function run() public {
        vm.startBroadcast();

        address HELLO_FIREWALL_ADDRESS = vm.envAddress("HF_HELLO_FIREWALL_ADDRESS");
        console.log("HelloFirewallPolicy Address is set to: ", HELLO_FIREWALL_ADDRESS);

        HelloFirewallPolicy helloFirewallPolicy = HelloFirewallPolicy(HELLO_FIREWALL_ADDRESS);
        helloFirewallPolicy.setIncrementThreshold(3);

        console.log("Threshold was set!");

        vm.stopBroadcast();
    }
}
