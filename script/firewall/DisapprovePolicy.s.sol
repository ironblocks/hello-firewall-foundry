// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8;

import {Script, console} from "forge-std/Script.sol";
import {IFirewall} from "../../src/firewall/interfaces/IFirewall.sol";

contract DisapprovePolicy is Script {
    function run() public {
        vm.startBroadcast();

        address FIREWALL_ADDRESS = vm.envAddress("HF_FIREWALL_ADDRESS");
        console.log("Firewall Address is set to: ", FIREWALL_ADDRESS);

        address POLICY_ADDRESS = vm.envAddress("HF_POLICY_ADDRESS");
        console.log("Policy Address is set to: ", POLICY_ADDRESS);

        IFirewall firewall = IFirewall(FIREWALL_ADDRESS);
        firewall.setPolicyStatus(POLICY_ADDRESS, false);

        console.log("HelloFirewallPolicy is now disapproved for further registration!");

        vm.stopBroadcast();
    }
}
