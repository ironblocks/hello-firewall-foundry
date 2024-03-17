// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8;

import {Script, console} from "forge-std/Script.sol";
import {HelloFirewall} from "../../src/HelloFirewall.sol";

contract SetFirewall is Script {
    function run() public {
        vm.startBroadcast();

        address HELLO_FIREWALL_ADDRESS = vm.envAddress("HF_HELLO_FIREWALL_ADDRESS");
        console.log("HelloFirewall Address is set to: ", HELLO_FIREWALL_ADDRESS);

        HelloFirewall helloFirewall = HelloFirewall(HELLO_FIREWALL_ADDRESS);
        helloFirewall.increment();

        console.log("Number incremented!");

        vm.stopBroadcast();
    }
}
