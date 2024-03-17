// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8;

import {Script, console} from "forge-std/Script.sol";
import {IFirewallConsumer} from "../../src/firewall/interfaces/IFirewallConsumer.sol";

contract SetFirewall is Script {
    function run() public {
        vm.startBroadcast();

        address FIREWALL_ADDRESS = vm.envAddress("HF_FIREWALL_ADDRESS");
        console.log("Firewall Address is set to: ", FIREWALL_ADDRESS);

        address HELLO_FIREWALL_ADDRESS = vm.envAddress("HF_HELLO_FIREWALL_ADDRESS");
        console.log("HelloFirewall Address is set to: ", HELLO_FIREWALL_ADDRESS);

        IFirewallConsumer helloFirewall = IFirewallConsumer(HELLO_FIREWALL_ADDRESS);
        helloFirewall.setFirewall(FIREWALL_ADDRESS);

        console.log("Firewall address set!");

        vm.stopBroadcast();
    }
}
