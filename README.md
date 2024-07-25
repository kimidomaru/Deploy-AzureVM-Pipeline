# Deploy-AzureVM-Pipeline

This project sets up an Azure VM environment, installs Nginx using Ansible, and integrates the process with GitHub Actions for CI/CD.

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [Usage](#usage)
- [Pipeline Details](#pipeline-details)
- [Terraform Configuration](#terraform-configuration)
- [Ansible Playbook](#ansible-playbook)
- [License](#license)

## Overview

This project automates the deployment of an Azure Virtual Machine (VM) and the installation of Nginx on it using Ansible. The entire process is managed through a GitHub Actions pipeline, ensuring continuous integration and deployment. It's also possible to deploy the Terraform/Ansible locally, passing the Azure Connection Variables.

At the end of the pipeline, a resource group named `student-rg` will be created in your Azure Subscription. This resource group will contain a Virtual Machine (VM), a Disk, a Public IP, a Network Interface, a Virtual Network (also a Subnet) and a Network Security Group (NSG). By accessing the VM's Public IP, you will see the Nginx welcome page.

## Prerequisites

- Azure Subscription
- GitHub Account
- Terraform installed locally (for manual runs)
- Ansible installed locally (for manual runs)
- GitHub Secrets configured for Azure credentials

### Installing Terraform and Ansible Locally

**Terraform:**

Follow the instructions [here](https://learn.hashicorp.com/tutorials/terraform/install-cli) to install Terraform on your local machine.

**Ansible:**

Install Ansible using pip:

```sh
pip install ansible
```
## Setup

1. **Clone the repository:**

    ```sh
    git clone https://github.com/yourusername/Deploy-AzureVM-Pipeline.git
    cd Deploy-AzureVM-Pipeline
    ```

2. **Configure GitHub Secrets:**

    Add the following secrets to your GitHub repository:

    1. **Navigate to your repository on GitHub.**
    2. **Go to the "Settings" tab.**
    3. **In the left sidebar, click on "Secrets and variables" and then "Actions".**
    4. **Click the "New repository secret" button.**
    5. **Add the following secrets:**

        - `ARM_CLIENT_ID` - Client ID of the Service Principal that will run Terraform
        - `ARM_CLIENT_SECRET` - Client Secret of the Service Principal
        - `ARM_TENANT_ID` - Azure Tenant
        - `ARM_SUBSCRIPTION_ID` - Azure Subscription
        - `AZURE_RESOURCE_GROUP_NAME` - Resource Group of the AzureRM remote Backend
        - `AZURE_STORAGE_ACCOUNT_NAME` - Storage Account of the Remote Backend
        - `AZURE_CONTAINER_NAME` - Container name of the remote Backend
        - `AZURE_STATE_FILE_KEY` - Name of the Blob file
        - `VM_ADMIN_PASSWORD` - Password of the VM Admin, used to make SSH connection
    
    Example:
    ```sh
        ARM_CLIENT_ID=your-client-id
        ARM_CLIENT_SECRET=your-client-secret
        ARM_TENANT_ID=your-tenant-id
        ARM_SUBSCRIPTION_ID=your-subscription-id
        AZURE_RESOURCE_GROUP_NAME=your-backend-resource-group
        AZURE_STORAGE_ACCOUNT_NAME=your-backend-storage-account
        AZURE_CONTAINER_NAME=your-backend-container
        AZURE_STATE_FILE_KEY=your-backend-state-file-key
        VM_ADMIN_PASSWORD=your-vm-admin-password
    ```
    6. **For each secret, enter the name and value, then click "Add secret".**

## Usage

1. **Trigger the GitHub Actions pipeline:**

    Create a new branch, make your changes, and open a pull request to the `main` branch to trigger the pipeline.

    ```sh
    git checkout -b feature-branch
    git add .
    git commit -m "Trigger pipeline"
    git push origin feature-branch
    ```

    Then, go to your GitHub repository and open a pull request from `feature-branch` to `main`.

2. **Monitor the pipeline:**

    Go to the Actions tab in your GitHub repository to monitor the progress of the pipeline.

## Pipeline Details

The GitHub Actions pipeline is defined in `terraform.yaml` and consists of three jobs:

1. **Lint:**
    - Checks out the code.
    - Installs Terraform.
    - Runs `terraform fmt` to check formatting.
    - Runs `tflint` for linting.

2. **Security Check:**
    - Runs Checkov for security scanning.

3. **Terraform and Ansible:**
    - Initializes Terraform.
    - Plans and applies the Terraform configuration.
    - Sets up Python and installs Ansible.
    - Runs the Ansible playbook to install Nginx.

## Terraform Configuration

The Terraform configuration is defined in `main.tf` and includes:

- Resource group
- Virtual network and subnet
- Network security group with rules for SSH and HTTP
- Public IP and network interface
- Linux virtual machine
- Local file resource to generate the Ansible inventory

## Ansible Playbook

The Ansible playbook is defined in `playbook.yaml` and includes tasks to:

- Update the apt cache
- Install Nginx
- Start Nginx

The inventory file is generated from a template (`inventory.tpl`) and includes the VM's public IP address and credentials.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.