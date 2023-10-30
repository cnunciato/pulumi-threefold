import os
import pulumi
import pulumi_threefold as threefold

mnemonic = os.environ['MNEMONIC']
network = os.environ['NETWORK']

provider = threefold.Provider("provider-test", mnemonic=mnemonic, network=network)

scheduler = threefold.Scheduler("scheduler",
    mru=256,
    sru=2048,
    farm_ids=[1],
    opts=pulumi.ResourceOptions(provider=provider))

network = threefold.Network("network",
    name="test",
    description="test network",
    nodes=[scheduler.nodes[0]],
    ip_range="10.1.0.0/16",
    opts=pulumi.ResourceOptions(provider=provider,
        depends_on=[scheduler]))

deployment = threefold.Deployment("deployment",
    node_id=scheduler.nodes[0],
    name="deployment",
    network_name="test",
    vms=[threefold.VMInputArgs(
        name="vm",
        flist="https://hub.grid.tf/tf-official-apps/base:latest.flist",
        entrypoint="/sbin/zinit init",
        network_name="test",
        cpu=2,
        memory=256,
        planetary=True,
        mounts=[threefold.MountArgs(
            disk_name="data",
            mount_point="/app",
        )],
        env_vars={
            "SSH_KEY": None,
        },
    )],
    disks=[threefold.DiskArgs(
        name="data",
        size=2,
    )],
    opts=pulumi.ResourceOptions(provider=provider,
        depends_on=[network]))

pulumi.export("node_deployment_id", deployment.node_deployment_id)
pulumi.export("ygg_ip", deployment.vms_computed[0].ygg_ip)
