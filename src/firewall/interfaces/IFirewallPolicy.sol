// SPDX-License-Identifier: UNLICENSED
// See LICENSE file for full license text.
// Copyright (c) Ironblocks 2024
pragma solidity ^0.8;

interface IFirewallPolicy {
    function preExecution(address consumer, address sender, bytes memory data, uint256 value) external;
    function postExecution(address consumer, address sender, bytes memory data, uint256 value) external;
}
