$Configuration = 'Release'
$DotNetVersion = 'net5.0'

# Define build output locations
$OutDir = "$PSScriptRoot\output"
$OutDependencies = "$OutDir\dependencies"

# Build both Core and PS projects
dotnet publish -c $Configuration

# Ensure output directories exist and are clean for build
New-Item -Path $OutDir -ItemType Directory -ErrorAction Ignore
Get-ChildItem $OutDir | Remove-Item -Recurse
New-Item -Path $OutDependencies -ItemType Directory

# Create array to remember copied files
$CopiedDependencies = @()

# Copy .dll and .pdb files from Core to the dependency directory
Get-ChildItem -Path "AzBlobConflict.Core\bin\$Configuration\$DotNetVersion\publish" |
    Where-Object { $_.Extension -in '.dll','.pdb' } |
    ForEach-Object {
        $CopiedDependencies += $_.Name
        Copy-Item -Path $_.FullName -Destination $OutDependencies
    }

# Copy files from PS to output directory, except those already copied from Core
Get-ChildItem -Path "AzBlobConflict.PS\bin\$Configuration\$DotNetVersion\publish" |
    Where-Object { $_.Name -notin $CopiedDependencies -and $_.Extension -in '.dll','.pdb' } |
    ForEach-Object {
        Copy-Item -Path $_.FullName -Destination $OutDir
    }