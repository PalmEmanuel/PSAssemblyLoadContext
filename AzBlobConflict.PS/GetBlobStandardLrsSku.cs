using AzBlobConflict.Core;
using System.Management.Automation;

namespace AzBlobConflict.PS
{
    [Cmdlet(VerbsCommon.Get, "BlobStandardLrsSku")]
    public class GetBlobStandardLrsSku : PSCmdlet
    {
        protected override void ProcessRecord()
        {
            WriteObject(BlobSkuWrapper.GetStandardLrsName());
        }
    }
}