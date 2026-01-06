resource ubuntuVM2storagesunki 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: toLower('ubuntuVM2storagesunki')
  location: resourceGroup().location
  tags: {
    displayName: 'ubuntuVM2 Storage Account'
  }
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'Storage'
}

resource ubuntuVM2_PublicIP 'Microsoft.Network/publicIPAddresses@2023-04-01' = {
  name: 'ubuntuVM2-PublicIP'
  location: resourceGroup().location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    publicIPAddressVersion: 'IPv4'
    dnsSettings: {
      domainNameLabel: toLower('ubuntuvm2')
    }
  }
}

resource ubuntuVM2_nsg 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: 'ubuntuVM2-nsg'
  location: resourceGroup().location
  properties: {
    securityRules: [
      {
        name: 'nsgRule1'
        properties: {
          description: 'description'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
        }
      }
    ]
  }
}

resource ubuntuVM2_VirtualNetwork 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: 'ubuntuVM2-VirtualNetwork'
  location: resourceGroup().location
  tags: {
    displayName: 'ubuntuVM2-VirtualNetwork'
  }
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'ubuntuVM2-VirtualNetwork-Subnet'
        properties: {
          addressPrefix: '10.0.0.0/24'
          networkSecurityGroup: {
            id: ubuntuVM2_nsg.id
          }
        }
      }
    ]
  }
}

resource ubuntuVM2_NetworkInterface 'Microsoft.Network/networkInterfaces@2023-04-01' = {
  name: 'ubuntuVM2-NetworkInterface'
  location: resourceGroup().location
  tags: {
    displayName: 'ubuntuVM2-NetworkInterface'
  }
  properties: {
    ipConfigurations: [
      {
        name: 'ipConfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: ubuntuVM2_PublicIP.id
          }
          subnet: {
            id: resourceId(
              'Microsoft.Network/virtualNetworks/subnets',
              'ubuntuVM2-VirtualNetwork',
              'ubuntuVM2-VirtualNetwork-Subnet'
            )
          }
        }
      }
    ]
  }
  dependsOn: [
    ubuntuVM2_VirtualNetwork
  ]
}

resource ubuntuVM2 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: 'ubuntuVM2'
  location: resourceGroup().location
  tags: {
    displayName: 'ubuntuVM2'
  }
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    osProfile: {
      computerName: 'ubuntuVM2'
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
        name: 'ubuntuVM2-OSDisk'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: ubuntuVM2_NetworkInterface.id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: ubuntuVM2storagesunki.properties.primaryEndpoints.blob
      }
    }
  }
}
