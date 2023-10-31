// Code generated by pulumi-language-go DO NOT EDIT.
// *** WARNING: Do not edit by hand unless you're certain you know what you are doing! ***

package config

import (
	"github.com/pulumi/pulumi/sdk/v3/go/pulumi"
	"github.com/pulumi/pulumi/sdk/v3/go/pulumi/config"
	"github.com/threefoldtech/pulumi-threefold/sdk/go/threefold/internal"
)

var _ = internal.GetEnvOrDefault

// The key type registered on substrate (ed25519 or sr25519).
func GetKey_type(ctx *pulumi.Context) string {
	v, err := config.Try(ctx, "threefold:key_type")
	if err == nil {
		return v
	}
	var value string
	if d := internal.GetEnvOrDefault("sr25519", nil, ""); d != nil {
		value = d.(string)
	}
	return value
}

// The mnemonic of the user. It is very secret.
func GetMnemonic(ctx *pulumi.Context) string {
	v, err := config.Try(ctx, "threefold:mnemonic")
	if err == nil {
		return v
	}
	var value string
	if d := internal.GetEnvOrDefault("", nil, ""); d != nil {
		value = d.(string)
	}
	return value
}

// The network to deploy on.
func GetNetwork(ctx *pulumi.Context) string {
	v, err := config.Try(ctx, "threefold:network")
	if err == nil {
		return v
	}
	var value string
	if d := internal.GetEnvOrDefault("", nil, ""); d != nil {
		value = d.(string)
	}
	return value
}

// The relay url, example: wss://relay.dev.grid.tf
func GetRelay_url(ctx *pulumi.Context) string {
	return config.Get(ctx, "threefold:relay_url")
}

// The timeout duration in seconds for rmb calls
func GetRmb_timeout(ctx *pulumi.Context) string {
	return config.Get(ctx, "threefold:rmb_timeout")
}

// The substrate url, example: wss://tfchain.dev.grid.tf/ws
func GetSubstrate_url(ctx *pulumi.Context) string {
	return config.Get(ctx, "threefold:substrate_url")
}
