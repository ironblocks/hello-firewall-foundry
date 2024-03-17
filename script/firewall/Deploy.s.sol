// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8;

import {Script, console} from "forge-std/Script.sol";
import {Firewall} from "../../src/firewall/Firewall.sol";

contract DeployFirewall is Script {
    function run() public {
        vm.startBroadcast();

        Firewall firewall = new Firewall();
        console.log("Firewall Deployed to: ", address(firewall));

        vm.stopBroadcast();
    }
}
