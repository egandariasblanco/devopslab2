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
## Error creando todas las máquinas con 2VCPU

```bash
Error: creating Linux Virtual Machine "nfs-vm" (Resource Group "kubendika-rg"): compute.VirtualMachinesClient#CreateOrUpdate: Failure sending request: StatusCode=0 -- Original Error: autorest/azure: Service returned an error. Status=<nil> Code="OperationNotAllowed" Message="Operation could not be completed as it results in exceeding approved standardAv2Family Cores quota. Additional details - Deployment Model: Resource Manager, Location: westeurope, Current Limit: 4, Current Usage: 4, Additional Required: 2, (Minimum) New Limit Required: 6. Submit a request for Quota increase at https://aka.ms/ProdportalCRP/?#create/Microsoft.Support/Parameters/%7B%22subId%22:%22a797792f-5377-45a0-9437-9368deae73c7%22,%22pesId%22:%2206bfd9d3-516b-d5c6-5802-169c800dec89%22,%22supportTopicId%22:%22e12e3d1d-7fa0-af33-c6d0-3c50df9658a3%22%7D by specifying parameters listed in the ‘Details’ section for deployment to succeed. Please read more about quota limits at https://docs.microsoft.com/en-us/azure/azure-supportability/per-vm-quota-requests."
```

Lo dejamos es 4 máquinas con la siguiente distribución de recursos:
- Master: 2 CPU 4GB RAM 20 GB DISCO (Standard_A2_v2)
- Worker1: 1 CPU 2GB RAM 10 GB DISCO (Standard_A1_v2)
- Worker2: 1 CPU 2GB RAM 10 GB DISCO (Standard_A1_v2)

Mi cliente prefiere no perder servicio ante errores. La aplicación es muy sencilla y no requiere de muchos recursos para un buen rendimiento. El nodo master será el que haga el papel de NFS por ser un nodo de infraestructura. Los playbooks de ansible se lanzaran también desde el master ya que desde un equipo local sería ineficiente al tener que conectarse a máquinas remotas en un entorno cloud.
Si hubiese elegido la configuración 1 master 1 worker tendría más rendimiento y el NFS no tendría sentido en la arquitectura ya que no habría necesidad de compartir ningún volumen entre nodos del cluster....porque no existe cluster como tal.