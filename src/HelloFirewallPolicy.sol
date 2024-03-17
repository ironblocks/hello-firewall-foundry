// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8;

import {FirewallPolicyBase} from "./firewall/FirewallPolicyBase.sol";

import {HelloFirewall} from "./HelloFirewall.sol";

contract HelloFirewallPolicy is FirewallPolicyBase {
    uint256 public incrementThreshold = 1;

    function preExecution(address consumer, address, bytes calldata, uint256) external view override {
        HelloFirewall helloFirewall = HelloFirewall(consumer);
        require(helloFirewall.number() < incrementThreshold, "Increment attempt exceeds threshold");
    }

    function postExecution(address, address, bytes calldata, uint256) external override {}

    function setIncrementThreshold(uint256 newThreshold) external {
        incrementThreshold = newThreshold;
    }
}
