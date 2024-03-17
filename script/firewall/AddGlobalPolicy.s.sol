// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8;

import {Script, console} from "forge-std/Script.sol";
import {IFirewall} from "../../src/firewall/interfaces/IFirewall.sol";

contract AddGlobalPolicy is Script {
    function run() public {
        vm.startBroadcast();

        address FIREWALL_ADDRESS = vm.envAddress("HF_FIREWALL_ADDRESS");
        console.log("Firewall Address is set to: ", FIREWALL_ADDRESS);

        address POLICY_ADDRESS = vm.envAddress("HF_POLICY_ADDRESS");
        console.log("Policy Address is set to: ", POLICY_ADDRESS);

        address HELLO_FIREWALL_ADDRESS = vm.envAddress("HF_HELLO_FIREWALL_ADDRESS");
        console.log("HelloFirewall Address is set to: ", HELLO_FIREWALL_ADDRESS);

        IFirewall firewall = IFirewall(FIREWALL_ADDRESS);
        firewall.addGlobalPolicy(HELLO_FIREWALL_ADDRESS, POLICY_ADDRESS);

        console.log("HelloFirewallPolicy was added to protect HelloFirewall!");

        vm.stopBroadcast();
    }
}
