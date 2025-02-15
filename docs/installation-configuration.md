---
title: Threefold Grid Installation & Configuration
meta_desc: Information on how to install the Threefold provider.
layout: package
---

## Installation

The Pulumi Threefold provider is available as a package in those Pulumi languages:

* Go: [`github.com/threefoldtech/pulumi-threefold/sdk`](https://pkg.go.dev/github.com/threefoldtech/pulumi-threefold/sdk)

## Setup

To provision resources with the Pulumi threefold provider, you need to provide the `mnemonic`.

## Configuration Options

Use `pulumi config set threefold:<option>`.

The following configuration points are available for the `threefold` provider:

* `threefold:mnemonic` (environment: `MNEMONIC`) -  This is the grid mnemonic. You can create a new account if you don't have [mnemonics](https://threefoldtech.github.io/info_grid/dashboard/portal/dashboard_portal_polkadot_create_account.html).

* `threefold:network` (environment: `NETWORK`) - specify which grid network (dev/qa/mainnet/testnet) to deploy on (default is dev).
