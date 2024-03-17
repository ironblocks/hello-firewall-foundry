# Hello Firewall

Everything you need to get started with Ironblocks' Firewall using Foundry.

**Table Of Contents**

- [Start Here](#start-here)
  - [Prerequisites](#prerequisites)
  - [Build](#build)
  - [Deploy & Setup](#deploy--setup)
- [Using The App](#using-the-app)
  - [Try It](#try-it)
  - [Hello Firewall Policy](#hello-firewall-policy)
- [Technical Details](#technical-details)
  - [Ownership](#ownership)
  - [Contracts](#contracts)
  - [Internal Wiring](#internal-wiring)
- [External References](#external-references)

#### Project Overview

This project serves as a **Hello World** example for getting started with Ironblocks' Firewall.

It includes 2 _(very)_ simple contracts to demonstrate how the Firewall works:

- `HelloFirewall.sol` - a simple counter-like smart contract
- `HelloFirewallPolicy.sol` - a security policy that limits counter increments to a set threshold

## Start Here

#### Prerequisites

1. This project uses Foundry, so make sure you have that installed before continuing.

#### Build

1. Build the project by running:

   ```shell
   forge build
   ```

#### Deploy & Setup

1. Open a new terminal, and start a local development with Anvil by running:

   ```shell
   anvil
   ```

2. Open a second terminal, and run the **`SetupEverything`** Solidity Script:

   ```shell
   forge script \
    --broadcast \
    --rpc-url "http://127.0.0.1:8545" \
    --private-key "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80" \
    script/SetupEverything.s.sol
   ```

##### Notes

1. You'll find a convenience helper script under **`bin/anvil/setup-everything.sh`** that runs the above command.

2. The private key belongs to the first account built into Anvil _(i.e. the first test account)_.

## Using The App

Now that everything is deployed, if you try to call `increment()` on the `HelloFirewall` smart contract, you'll notice that only the first call works.

#### Try It

1. Run the `Increment` Solidity Script to increment the number stored by our `HelloFirewall` example contract:

   ```shell
   forge script \
   --broadcast \
   --rpc-url "http://127.0.0.1:8545" \
   --private-key "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80" \
   script/hello-firewall/Increment.s.sol
   ```

2. Run the script again.  
   This time it, the call gets blocked by the Firewall.

#### Hello Firewall Policy

The second transaction failed, because the `HelloFirewallPolicy` is preventing increments larger than a configured threshold. For simplicity, the default threshold is set to **`1`**.

1. Run the `setIncrementThreshold` Solidity Script which is hardcoded to update the threshold to **`3`**:

   ```shell
    forge script \
   --broadcast \
   --rpc-url "http://127.0.0.1:8545" \
   --private-key "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80" \
   script/hello-firewall-policy/SetIncrementThreshold.s.sol
   ```

2. Now that the policy's configuration was updated, we can send 2 additional `Increment` requests by calling the `Increment` Solidity Script two more times:

   ```shell
   forge script \
   --broadcast \
   --rpc-url "http://127.0.0.1:8545" \
   --private-key "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80" \
   script/hello-firewall/Increment.s.sol
   ```

   > _\* run this twice_

3. Lastly, if you try to call `Increment` for a third time, it will again be prevented by the `HelloFirewallPolicy`.

## Technical Details

If you examine the `SetupEverything` Solidity Script, you'll notice there are several steps required to protect a smart contract. Let's recap what contracts and configurations were set up.

#### Ownership

For the purpose of simplicity, all the contracts that are deployed and used in this project are owned by the same account - the default first account provided by `Anvil`.

#### Contracts

- **`Firewall.sol`** - this is the smart contract for the Firewall. It provides methods that allow a Firewall Consumer to subscribe or unsubscribe to security policies. It also allows the Firewall Owner to approve or disapprove which security policies will be available to Firewall Consumers

  > The `Firewall Owner` is the principal that deployed the Firewall
  >
  > The `Firewall Consumer` is a smart contract - such as our `HelloFirewall.sol` - which inherits the `FirewallConsumer` so that it can consume security services from the Firewall.

- **`HelloFirewall.sol`** - this is our demo counter smart contract

- **`HelloFirewallPolicy.sol`** - this is our custom security policy, which prevents anyone from incrementing the counter above a configurable threshold

#### Internal Wiring

1. Every transaction sent to our `HelloFirewall` contract will be examined the `Firewall`. For this to work, we first need to tell it what `Firewall` to use.  
   We do this by calling `setFirewall(FIREWALL_ADDRESS)` on the `HelloFirewall` smart contract.

2. As an additional layer of security, only policies that have been approved by a `Firewall Owner` will be available to `Firewall Consumers` for them to subscribe to said policies.  
   This is done by calling `setPolicyStatus(POLICY_ADDRESS, BOOLEAN)` on the `Firewall`. > The `Firewall Owner` in this demo is the same account that deploys the `HelloFirewall`.

   > In real world scenarios, the `Firewall Owner` may be any principal _(person, people, or organization)_, as governed or decentralized as needed _(i.e. DAO etc.)_

3. Lastly, our `HelloFirewall` smart contract needs to tell the `Firewall` what security policies should be configured to protect it. In our case, we tell the `Firewall` that we want the `HelloFirewallPolicy` security policy to protect any calls to our smart contract. We do this with `addGlobalPolicy(OUR_ADDRESS, POLICY_ADDRESS)`.
   > Note that only functions that have the `firewallProtected` modifier will be protected by the `Firewall`
   >
   > More advanced modifiers are also available, see the official documentation for more info _(link below)_

## External References

- Official Documentation
- Discord Channel
- Website
