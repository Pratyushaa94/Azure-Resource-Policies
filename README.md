# Azure Storage Lifecycle Management with Terraform & GitHub Actions

##  What This Does

- Provisions an Azure Storage Account
- Creates a Blob Container
- Enables Lifecycle Management (cool/archive/delete rules)
- Automates Terraform deployment using GitHub Actions
- Manages infrastructure state and cost efficiently

---

##  Project Structure

```
.
├── main.tf                      # Terraform resources
├── provider.tf                  # Azure provider config
├── variables.tf                 # Input variable declarations
├── terraform.tfvars             # Default variable values
├── environments/
│   ├── dev.tfvars               # Dev-specific variables
│   ├── prod.tfvars              # Prod-specific variables
│   ├── uat.tfvars               # UAT-specific variables
│   └── backend.tf               # Remote state backend config
└── .github/
    └── workflows/
        └── deploy.yml           # GitHub Actions CI/CD pipeline
```

##  Generate Azure Credentials

```bash
az ad sp create-for-rbac   --name "GitHubActionsLifecycle"   --role Contributor   --scopes /subscriptions/$(az account show --query id -o tsv)   --sdk-auth
```

Save the JSON output in your GitHub repo as a secret named: `AZURE_CREDENTIALS` and `INFRA_API_KEY`

---

## GitHub Secrets Required

| Secret Name             | Description                               |
|-------------------------|-------------------------------------------|
| `AZURE_CREDENTIALS`     | Entire JSON output from the SP command    |
| `INFRACOST_API_KEY`     | Your Infracost API key                    |


---

##  Remote State Backend (environments/backend.tf)

| Property         | Value                  |
|------------------|------------------------|
| Storage Account  | prathyushastateacct    |
| Container        | tfstate                |
| State File Name  | lifecycle.tfstate      |

---

##  GitHub Actions Workflow

Trigger: On push to `main`

### Steps:
1. Authenticate with Azure using secrets
2. Validate backend state config
3. Run `terraform init`
4. Run `terraform plan`
5. Generate plan and cost estimation
6. Await approval (GitHub Environment)
7. Apply changes

---

##  How to Use

### 1. Clone the Repo

```bash
git clone https://github.com/Pratyushaa94/Azure-Resource-Policies.git
cd Azure-Resource-Policies
```

### 2. Edit terraform.tfvars

```hcl
resource_group_name   = "my-rg"
storage_account_name  = "prathyushalifecycle"
container_name        = "mycontainer"
location              = "East US"
cool_tier_days        = 30
archive_tier_days     = 90
```

> `storage_account_name` must be globally unique, lowercase.

### 3. Run Terraform Manually (Optional)

```bash
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
```

### 4. Push to GitHub (CI/CD)

```bash
git checkout -b feature/lifecycle-policy
git add .
git commit -m "Add storage lifecycle automation"
git push -u origin feature/lifecycle-policy
```

GitHub Actions will now:

- Authenticate
- Plan
- Wait for approval (optional)
- Apply

---

##  Lifecycle Rules Summary

### Rule 1: Modification-Based

| Action             | Trigger (days) |
|--------------------|----------------|
| Cool Tier          | 30             |
| Archive Tier       | 90             |
| Delete Blobs       | 365            |
| Delete Snapshots   | 30             |
| Delete Versions    | 90             |

### Rule 2: Access-Based

| Action             | Trigger (days) |
|--------------------|----------------|
| Cool Tier          | 30 (accessed)  |
| Archive Tier       | 90 (accessed)  |
| Delete             | Custom         |

> Enable access tracking:
```hcl
blob_properties {
  last_access_time_enabled = true
}
```

---

##  Best Practices

-  Secret-based authentication
-  Automated lifecycle and cleanup
- Cost optimization with Infracost (optional)
-  CI/CD with GitHub Actions
-  Infrastructure as Code using Terraform

---

##  Use Cases

- Cold/archive blob storage
- Data compliance and cleanup
- Blob versioning cleanup
- Cost-effective storage management

---
