# Azure VM Provisioning with Terraform

This project provisions an Azure Virtual Machine using Terraform. It supports multiple admin users via SSH keys, custom VM sizing, and tagging for IaC.

## Prerequisites
- [Terraform](https://www.terraform.io/downloads.html) installed
- Azure CLI installed and authenticated (`az login`)
- Sufficient permissions to create resources in the target Azure subscription
- SSH public keys for all admin users

## Setup
1. **Clone this repository** and navigate to the project directory.

2. **Edit `terraform.tfvars`** to set your Azure resource group, subscription, network, VM size, and admin SSH keys. Example:

```hcl
resource_name   = "smartlp"
subscription_id = "<your-subscription-id>"
vpc_cidr_block  = "10.0.0.0/18"
vm_size         = "Standard_NC40ads_H100_v5"

admin_ssh_keys = [
  {
    username   = "mehfuz"
    public_key = file("/home/mehfuz/.ssh/id_rsa.pub")
  },
  {
    username   = "john"
    public_key = file("/home/john/.ssh/id_rsa.pub")
  },
  {
    username   = "chris"
    public_key = file("/home/chris/.ssh/id_rsa.pub")
  }
]
```

3. **Initialize Terraform:**
```bash
terraform init
```

4. **Review the plan:**
```bash
terraform plan
```

5. **Apply the plan:**
```bash
terraform apply
```
- Confirm the action when prompted.

## Outputs
- The public IP address of the VM will be displayed after a successful apply.
- Admin users are provisioned as specified in `terraform.tfvars`.

## Notes
- The VM is created in the specified resource group and region.
- Secure boot is disabled by default.
- The VM is tagged with `IaC = true`.
- To destroy the resources, run:
  ```bash
  terraform destroy
  ```

## Troubleshooting
- Ensure your SSH public key files exist and are readable.
- Make sure you have the correct permissions in Azure.
- If you see variable errors, check that all required variables are set in `terraform.tfvars`.

---

For more details, see the comments in each `.tf` file.
