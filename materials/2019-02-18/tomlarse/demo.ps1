#Connect-AzAccount

# Get a list of resource groups
# Get-AzResourceGroup | Select-Object ResourceGroupName, Location, ProvisioningState

# Create a new Storage Account. It Needs to be StorageV2
$storageAccount = New-AzStorageAccount -ResourceGroupName "docsplay" -Name "psphdemo" -Location 'North Europe' -SkuName Standard_LRS -Kind StorageV2

# Or if you have a suitable account already, load it in to a variable.
$storageAccount = Get-AzStorageAccount -ResourceGroupName "docsplay" -Name "psphdemo"

# Enable static website functionality
Enable-AzStorageStaticWebsite -Context $storageAccount.Context -IndexDocument "index.html" -ErrorDocument404Path "404.html"

# Verify that the $web container has been created.
Get-AzStorageContainer -Context $storageAccount.Context

# Upload the files
# Remember to adjust the remove index according to the site folder fullname.
Get-ChildItem .\site -File -Recurse | Foreach {
    $blobName = $_.FullName.Remove(0,24).Replace("\","/")
    Set-AzStorageBlobContent -Blob $blobname -File $_.FullName -Container '$web' -Context $storageAccount.Context -Properties @{"ContentType" = [system.web.mimemapping]::GetMimeMapping($_.FullName)}
}

# Get the url for the site
$storageAccount.PrimaryEndpoints.Web
