# Terraform GCP Domain Restricted Sharing Temporary Override

This is a quick and dirty module you can use in your Terraform configurations to get around scenarios where you have enabled domain-restricted sharing at top-level, but want to add google/gsuite*/gserviceaccount* permissions via IAM to child projects.

## How to use

Add the following block to your configurations:

```hcl
module "drs-override" {
    project_id = "your_project_id"
    resources = [google_project_iam_policy.compute, google_pubsub_iam_policy.push]
}
```

Now when you run your `terraform apply`, the resource graph will have a resource added to change the DRS policy to `any`. It will also have a resource that changes it back to the default, but that resource depends on the creation of the resources you specify in `resources`. Now with just a little extra code, you can continue to keep your IAM policy in Terraform and not have to jump over to the cloud console to disable DRS when you are running applies.

### Permissions

The account that runs this will need the `roles/orgpolicy.policyAdmin` in order to get the `orgpolicy.policy.set` and `orgpolicy.policy.get` permissions. These cannot be granted to a custom role and granting this permission to arbitrary accounts may run afoul of your organization's security policies. It is strongly recommended that you only use this through a tightly-controlled and audited service account in an automated context.