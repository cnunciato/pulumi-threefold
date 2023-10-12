// *** WARNING: this file was generated by pulumi-language-nodejs. ***
// *** Do not edit by hand unless you're certain you know what you are doing! ***

import * as pulumi from "@pulumi/pulumi";
import * as utilities from "../utilities";

export class Network extends pulumi.CustomResource {
    /**
     * Get an existing Network resource's state with the given name, ID, and optional extra
     * properties used to qualify the lookup.
     *
     * @param name The _unique_ name of the resulting resource.
     * @param id The _unique_ provider ID of the resource to lookup.
     * @param opts Optional settings to control the behavior of the CustomResource.
     */
    public static get(name: string, id: pulumi.Input<pulumi.ID>, opts?: pulumi.CustomResourceOptions): Network {
        return new Network(name, undefined as any, { ...opts, id: id });
    }

    /** @internal */
    public static readonly __pulumiType = 'threefold:provider:Network';

    /**
     * Returns true if the given object is an instance of Network.  This is designed to work even
     * when multiple copies of the Pulumi SDK have been loaded into the same process.
     */
    public static isInstance(obj: any): obj is Network {
        if (obj === undefined || obj === null) {
            return false;
        }
        return obj['__pulumiType'] === Network.__pulumiType;
    }

    public /*out*/ readonly access_wg_config!: pulumi.Output<string>;
    public readonly add_wg_access!: pulumi.Output<boolean | undefined>;
    public readonly description!: pulumi.Output<string>;
    public /*out*/ readonly external_ip!: pulumi.Output<string>;
    public /*out*/ readonly external_sk!: pulumi.Output<string>;
    public readonly ip_range!: pulumi.Output<string>;
    public readonly name!: pulumi.Output<string>;
    public /*out*/ readonly node_deployment_id!: pulumi.Output<{[key: string]: number}>;
    public readonly nodes!: pulumi.Output<any[]>;
    public /*out*/ readonly nodes_ip_range!: pulumi.Output<{[key: string]: string}>;
    public /*out*/ readonly public_node_id!: pulumi.Output<number>;
    public readonly solution_type!: pulumi.Output<string | undefined>;

    /**
     * Create a Network resource with the given unique name, arguments, and options.
     *
     * @param name The _unique_ name of the resource.
     * @param args The arguments to use to populate this resource's properties.
     * @param opts A bag of options that control this resource's behavior.
     */
    constructor(name: string, args: NetworkArgs, opts?: pulumi.CustomResourceOptions) {
        let resourceInputs: pulumi.Inputs = {};
        opts = opts || {};
        if (!opts.id) {
            if ((!args || args.description === undefined) && !opts.urn) {
                throw new Error("Missing required property 'description'");
            }
            if ((!args || args.ip_range === undefined) && !opts.urn) {
                throw new Error("Missing required property 'ip_range'");
            }
            if ((!args || args.name === undefined) && !opts.urn) {
                throw new Error("Missing required property 'name'");
            }
            if ((!args || args.nodes === undefined) && !opts.urn) {
                throw new Error("Missing required property 'nodes'");
            }
            resourceInputs["add_wg_access"] = args ? args.add_wg_access : undefined;
            resourceInputs["description"] = args ? args.description : undefined;
            resourceInputs["ip_range"] = args ? args.ip_range : undefined;
            resourceInputs["name"] = args ? args.name : undefined;
            resourceInputs["nodes"] = args ? args.nodes : undefined;
            resourceInputs["solution_type"] = args ? args.solution_type : undefined;
            resourceInputs["access_wg_config"] = undefined /*out*/;
            resourceInputs["external_ip"] = undefined /*out*/;
            resourceInputs["external_sk"] = undefined /*out*/;
            resourceInputs["node_deployment_id"] = undefined /*out*/;
            resourceInputs["nodes_ip_range"] = undefined /*out*/;
            resourceInputs["public_node_id"] = undefined /*out*/;
        } else {
            resourceInputs["access_wg_config"] = undefined /*out*/;
            resourceInputs["add_wg_access"] = undefined /*out*/;
            resourceInputs["description"] = undefined /*out*/;
            resourceInputs["external_ip"] = undefined /*out*/;
            resourceInputs["external_sk"] = undefined /*out*/;
            resourceInputs["ip_range"] = undefined /*out*/;
            resourceInputs["name"] = undefined /*out*/;
            resourceInputs["node_deployment_id"] = undefined /*out*/;
            resourceInputs["nodes"] = undefined /*out*/;
            resourceInputs["nodes_ip_range"] = undefined /*out*/;
            resourceInputs["public_node_id"] = undefined /*out*/;
            resourceInputs["solution_type"] = undefined /*out*/;
        }
        opts = pulumi.mergeOptions(utilities.resourceOptsDefaults(), opts);
        super(Network.__pulumiType, name, resourceInputs, opts);
    }
}

/**
 * The set of arguments for constructing a Network resource.
 */
export interface NetworkArgs {
    add_wg_access?: pulumi.Input<boolean>;
    description: pulumi.Input<string>;
    ip_range: pulumi.Input<string>;
    name: pulumi.Input<string>;
    nodes: pulumi.Input<any[]>;
    solution_type?: pulumi.Input<string>;
}
