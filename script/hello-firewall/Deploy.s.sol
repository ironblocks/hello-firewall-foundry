// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8;

import {Script, console} from "forge-std/Script.sol";

import {HelloFirewall} from "../../src/HelloFirewall.sol";

contract DeployHelloFirewall is Script {
    function run() public {
        vm.startBroadcast();

        HelloFirewall helloFirewall = new HelloFirewall();
        console.log("HelloFirewall Deployed to: ", address(helloFirewall));

        vm.stopBroadcast();
    }
}
