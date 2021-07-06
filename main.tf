# Unsets a domain for domain restricted sharing to allow any domain to be added
resource "google_project_organization_policy" "domain_restricted_sharing_disable" {
  project = var.project_id
  constraint = "iam.allowedPolicyMemberDomains"

  list_policy {
    allow {
      all = true
    }
  }
}

# After resources in depends_on are put in place, policy from parent is restored
resource "google_project_organization_policy" "domain_restricted_sharing_enable" {
  depends_on = var.resources
  project = var.project_id
  constraint = "iam.allowedPolicyMemberDomains"
}