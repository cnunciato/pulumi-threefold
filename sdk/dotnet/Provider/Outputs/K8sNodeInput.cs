// *** WARNING: this file was generated by pulumi. ***
// *** Do not edit by hand unless you're certain you know what you are doing! ***

using System;
using System.Collections.Generic;
using System.Collections.Immutable;
using System.Threading.Tasks;
using Pulumi.Serialization;

namespace Pulumi.Threefold.Provider.Outputs
{

    [OutputType]
    public sealed class K8sNodeInput
    {
        public readonly int Cpu;
        public readonly int Disk_size;
        public readonly string? Flist;
        public readonly string? Flist_checksum;
        public readonly int Memory;
        public readonly string Name;
        public readonly object Node;
        public readonly bool? Planetary;
        public readonly bool? Public_ip;
        public readonly bool? Public_ip6;

        [OutputConstructor]
        private K8sNodeInput(
            int cpu,

            int disk_size,

            string? flist,

            string? flist_checksum,

            int memory,

            string name,

            object node,

            bool? planetary,

            bool? public_ip,

            bool? public_ip6)
        {
            Cpu = cpu;
            Disk_size = disk_size;
            Flist = flist;
            Flist_checksum = flist_checksum;
            Memory = memory;
            Name = name;
            Node = node;
            Planetary = planetary;
            Public_ip = public_ip;
            Public_ip6 = public_ip6;
        }
    }
}
