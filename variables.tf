variable "project_id" {
  description = "Project ID where this policy needs to be temporarily disabled"
  type        = string
}

variable "resources" {
  description = "List of resources that need to have domain restricted sharing temporarily disabled"
  type        = list(any)
  default     = []
}