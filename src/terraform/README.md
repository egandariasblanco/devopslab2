## Instalación de terraform
https://learn.hashicorp.com/tutorials/terraform/install-cli

## Instalación del cliente de azure (Caso MacOS)
brew install azure-cli

[Otros casos](https://docs.microsoft.com/es-es/cli/azure/install-azure-cli)

## az login 

Haciendo login se crea un subscription id

```json
[
  {
    "cloudName": "AzureCloud",
    "homeTenantId": "sdfgsdfgsdf",
    "id": "subscripcionxxxxx",
    "isDefault": true,
    "managedByTenants": [],
    "name": "Azure para estudiantes",
    "state": "Enabled",
    "tenantId": "sdfgsdfgsdfg",
    "user": {
      "name": "aaaaaaaaa",
      "type": "user"
    }
  }
]
```
Después de crear el subscrition id se puede consultar mediante `az account list`

## Service Principal
```bash
% az account set --subscription=subscripcionxxxxxxxxxx
% az ad sp create-for-rbac --role="Contributor" --name "-cli"
Creating 'Contributor' role assignment under scope '/subscriptions/subscripcionxxxxxxx'
  Retrying role assignment creation: 1/36
  Retrying role assignment creation: 2/36
The output includes credentials that you must protect. Be sure that you do not include these credentials in your code or check the credentials into your source control. For more information, see https://aka.ms/azadsp-cli
{
  "appId": "8c41de0f-5bcc-43bd-9b91-711a77fbbcaa",
  "displayName": "xxx-cli",
  "name": "http://xxxx-cli",
  "password": "xxxxxx",
  "tenant": "xxxxxxx"
}
```
