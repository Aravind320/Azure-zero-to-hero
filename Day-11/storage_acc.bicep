resource aravindsunki991 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'aravindsunki991'
  tags: {
    displayName: 'aravindsunki991'
  }
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Premium_LRS'
    tier: 'Premium'
  }
}
