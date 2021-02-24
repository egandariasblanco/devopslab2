## Instalación de terraform
https://learn.hashicorp.com/tutorials/terraform/install-cli

## Instalación del cliente de azure 
brew install azure-cli

## az login 

Haciendo login se crea un subscription id

```json
[
  {
    "cloudName": "AzureCloud",
    "homeTenantId": "899789dc-202f-44b4-8472-a6d40f9eb440",
    "id": "a797792f-5377-45a0-9437-9368deae73c7",
    "isDefault": true,
    "managedByTenants": [],
    "name": "Azure para estudiantes",
    "state": "Enabled",
    "tenantId": "899789dc-202f-44b4-8472-a6d40f9eb440",
    "user": {
      "name": "endika.gandarias597@comunidadunir.net",
      "type": "user"
    }
  }
]
```
Después de crear el subscrition id se puede consultar mediante `az account list`

## Service Principal
```bash
(base) Endika@MacBook-Pro Caso_practico_2 % az account set --subscription=a797792f-5377-45a0-9437-9368deae73c7
(base) Endika@MacBook-Pro Caso_practico_2 % az ad sp create-for-rbac --role="Contributor" --name "endika-cli"
Creating 'Contributor' role assignment under scope '/subscriptions/a797792f-5377-45a0-9437-9368deae73c7'
  Retrying role assignment creation: 1/36
  Retrying role assignment creation: 2/36
The output includes credentials that you must protect. Be sure that you do not include these credentials in your code or check the credentials into your source control. For more information, see https://aka.ms/azadsp-cli
{
  "appId": "8c41de0f-5bcc-43bd-9b91-711a77fbbcaa",
  "displayName": "endika-cli",
  "name": "http://endika-cli",
  "password": "Fv8G.8S5ScIjycRC9X67NuN..agu2TOyBT",
  "tenant": "899789dc-202f-44b4-8472-a6d40f9eb440"
}
```
