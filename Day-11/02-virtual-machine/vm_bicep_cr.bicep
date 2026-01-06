resource ubuntuVM 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: 'aravind1231'
  location: resourceGroup().location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    osProfile: {
      computerName: 'ubuntuVM'
      adminUsername: 'azureuser'
      adminPassword: 'azureuser@123'
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: 'UbuntuServer'
        sku: '16.04-LTS'
        version: 'latest'
      }
      osDisk: {
        name: 'name'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: '[resourceId('Microsoft.Network/networkInterfaces', 'ubuntuVM1-NetworkInterface')]'
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: 'storageUri'
      }
    }
  }
}
