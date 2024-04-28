# Configuración de service account para autenticar Terraform con GCP

-   Ver el [siguiente video](https://youtu.be/KilW1B8gxW4?si=EyeC7kTnZO5Otjzr) que explica como crear la service account y obtener las keys en formato `.json`.
-   Copiar el archivo descargado en el directorio raíz y renombrarlo a `credentials.json`.
-   Otorgarle permisos de 'Editor' a la service account en la sección de IAM de GCP console.

## Creación de infraestructura

-   Ejecutar terraform para crear la instancia de la VM en GCP.

```bash
terraform apply -auto-approve

# Otra alternativa es ejecutar el siguiente script:
sh runner.sh
```

-   Para conectarse por ssh, ejecutamos el siguiente script:

```bash
sh ssh-connect.sh
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

| Name                                                                     | Version  |
| ------------------------------------------------------------------------ | -------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.4.5 |
| <a name="requirement_google"></a> [google](#requirement_google)          | >=4.60.0 |

## Providers

| Name                                                      | Version |
| --------------------------------------------------------- | ------- |
| <a name="provider_google"></a> [google](#provider_google) | 5.25.0  |
| <a name="provider_local"></a> [local](#provider_local)    | 2.5.1   |
| <a name="provider_tls"></a> [tls](#provider_tls)          | 4.0.5   |

## Modules

No modules.

## Resources

| Name                                                                                                                                            | Type        |
| ----------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [google_compute_firewall.allow_http](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall)           | resource    |
| [google_compute_firewall.allow_https](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall)          | resource    |
| [google_compute_firewall.allow_ssh](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall)            | resource    |
| [google_compute_instance.vm_instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance)          | resource    |
| [google_project_service.cloud_resource_manager](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource    |
| [google_project_service.compute](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service)                | resource    |
| [local_file.instance_ip](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file)                                    | resource    |
| [local_file.ssh_private_key_pem](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file)                            | resource    |
| [local_file.username](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file)                                       | resource    |
| [tls_private_key.keys](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key)                                 | resource    |
| [google_client_openid_userinfo.me](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_openid_userinfo)    | data source |

## Inputs

| Name                                                                                                   | Description | Type     | Default                    | Required |
| ------------------------------------------------------------------------------------------------------ | ----------- | -------- | -------------------------- | :------: |
| <a name="input_credentials_file_path"></a> [credentials_file_path](#input_credentials_file_path)       | n/a         | `string` | `"credentials.json"`       |    no    |
| <a name="input_metadata_startup_script"></a> [metadata_startup_script](#input_metadata_startup_script) | n/a         | `string` | `"init.sh"`                |    no    |
| <a name="input_nodes"></a> [nodes](#input_nodes)                                                       | n/a         | `number` | `1`                        |    no    |
| <a name="input_project_id"></a> [project_id](#input_project_id)                                        | n/a         | `string` | `"braided-complex-416718"` |    no    |
| <a name="input_region"></a> [region](#input_region)                                                    | n/a         | `string` | `"us-east1"`               |    no    |
| <a name="input_zone"></a> [zone](#input_zone)                                                          | n/a         | `string` | `"us-east1-b"`             |    no    |

## Outputs

| Name                                                                                         | Description                                  |
| -------------------------------------------------------------------------------------------- | -------------------------------------------- |
| <a name="output_instance_ip"></a> [instance_ip](#output_instance_ip)                         | n/a                                          |
| <a name="output_instance_public_ips"></a> [instance_public_ips](#output_instance_public_ips) | The public IP addresses of the VM instances. |
| <a name="output_ssh_private_key"></a> [ssh_private_key](#output_ssh_private_key)             | n/a                                          |
| <a name="output_ssh_public_key"></a> [ssh_public_key](#output_ssh_public_key)                | n/a                                          |
| <a name="output_username"></a> [username](#output_username)                                  | Email of the authenticated user.             |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
