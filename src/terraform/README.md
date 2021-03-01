## Instalación de terraform
https://learn.hashicorp.com/tutorials/terraform/install-cli

Lo dejamos es 4 máquinas con la siguiente distribución de recursos:
- Master: 2 CPU 4GB RAM 20 GB DISCO (Standard_A2_v2)
- Worker1: 1 CPU 2GB RAM 10 GB DISCO (Standard_A1_v2)
- Worker2: 1 CPU 2GB RAM 10 GB DISCO (Standard_A1_v2)

Mi cliente prefiere no perder servicio ante errores. La aplicación es muy sencilla y no requiere de muchos recursos para un buen rendimiento. El nodo master será el que haga el papel de NFS por ser un nodo de infraestructura. Los playbooks de ansible se lanzaran también desde el master ya que desde un equipo local sería ineficiente al tener que conectarse a máquinas remotas en un entorno cloud.
Si hubiese elegido la configuración 1 master 1 worker tendría más rendimiento y el NFS no tendría sentido en la arquitectura ya que no habría necesidad de compartir ningún volumen entre nodos del cluster....porque no existe cluster como tal.
