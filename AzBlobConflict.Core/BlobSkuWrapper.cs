using System;
using Azure.Storage.Blobs.Models;

namespace AzBlobConflict.Core
{
    // This enum is a mirror of the one called SkuName found in the SDK
    public enum BlobSkuName
    {
        StandardLrs,
        StandardGrs,
        StandardRagrs,
        StandardZrs,
        PremiumLrs
    }
    public static class BlobSkuWrapper
    {
        public static BlobSkuName GetStandardLrsName()
        {
            // The only important thing for the example is that we reference the dependency somehow
            BlobSkuName standardLrs;
            // In this case we just parse the SkuName enum from the SDK to our own enum
            Enum.TryParse(SkuName.StandardLrs.ToString(), out standardLrs);

            return standardLrs;
        }
    }
}