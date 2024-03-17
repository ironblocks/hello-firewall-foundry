// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8;

import {FirewallConsumer} from "./firewall/FirewallConsumer.sol";

contract HelloFirewall is FirewallConsumer {
    uint256 public number;

    function increment() external firewallProtected {
        number++;
    }
}
