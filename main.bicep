@description('Name of the connected Container Registry')
param containerRegistryName string = 'salimai009'

@description('Name of the TodoApi Container App')
param ContainerAppName string = 'salimai009'

@description('Name of the TodoApi Container App')
param containerAppPlanName string = 'salimai009'

// @description('Name of Log Analytics Workspace')
// param logAnalyticsWorkspaceName string = 'salimai003'

// @description('Name of the App Service Environment')
// param environment_name string = 'salimai003'

param location string = resourceGroup().location



resource containerRegistry 'Microsoft.ContainerRegistry/registries@2021-12-01-preview' = {
  name: containerRegistryName
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
  }
}




// resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
//   name: logAnalyticsWorkspaceName
//   location: location
//   properties: any({
//     retentionInDays: 30
//     features: {
//       searchVersion: 1
//     }
//     sku: {
//       name: 'PerGB2018'
//     }
//   })
// }

// resource environment 'Microsoft.App/managedEnvironments@2022-03-01' = {
//   name: environment_name
//   location: location
//   properties: {
//     appLogsConfiguration: {
//       destination: 'log-analytics'
//       logAnalyticsConfiguration: {
//         customerId: reference(logAnalyticsWorkspace.id, '2020-03-01-preview').customerId
//         sharedKey: listKeys(logAnalyticsWorkspace.id, '2020-03-01-preview').primarySharedKey
//       }
//     }
//   }
// }

// resource customimagecontainerapp 'Microsoft.App/containerApps@2022-01-01-preview' = {
//   name: ContainerAppName
//   location: location
//   properties: {
//     managedEnvironmentId: environment.id
//     configuration: {
//       secrets: [
//         {
//           name: 'container-registry-password'
//           value: containerRegistry.listCredentials().passwords[0].value
//         }
//       ]
//       ingress: {
//         external: true
//         targetPort: 80
//       }
//       registries: [
//         {
//           // server is in the format of myregistry.azurecr.io
//           server: containerRegistry.name
//           username: containerRegistry.properties.loginServer
//           passwordSecretRef: 'container-registry-password'
//         }
//       ]
//     }
//     template: {
//       containers: [
//         {
//           // This is in the format of myregistry.azurecr.io
//           image: 'mcr.microsoft.com/azuredocs/containerapps-helloworld:latest'
//           name: ContainerAppName
//           resources: {
//             cpu: json('0.5') 
//             memory: '1.0Gi'
//           }
//         }
//       ]
//       scale: {
//         minReplicas: 1
//         maxReplicas: 1
//       }
//     }
//   }
// }


resource servicePlan 'Microsoft.Web/serverfarms@2016-09-01' = {
  kind: 'linux'
  name: containerAppPlanName
  location: location
  properties: {
    name: containerAppPlanName
    reserved: true
  }
  sku: {
    name: 'P1v3'
  }
  dependsOn: []
}

resource siteName_resource 'Microsoft.Web/sites@2016-08-01' = {
  name: ContainerAppName
  location: location
  properties: {
    siteConfig: {
      appSettings: [
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: containerRegistry.properties.loginServer
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_USERNAME'
          value: containerRegistry.name
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_PASSWORD'
          value: containerRegistry.listCredentials().passwords[0].value
        }
      ]
      linuxFxVersion: 'DOCKER'
    }
    serverFarmId: servicePlan.id
  }
}
