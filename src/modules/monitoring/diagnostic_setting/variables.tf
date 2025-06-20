variable "target_resource_id" {
  description = "The ID of the resource to apply diagnostics to"
  type        = string
}

variable "diagnostic_name" {
  description = "The name of the diagnostic setting"
  type        = string
  default     = "default"
}

variable "log_analytics_workspace_id" {
  description = "Optional Log Analytics workspace ID"
  type        = string
  default     = null
}

variable "storage_account_id" {
  description = "Optional Storage Account ID for logs"
  type        = string
  default     = null
}

variable "logs" {
  description = "List of logs to collect"
  type = list(object({
    category = string
    enabled  = bool
  }))
  default = []
}

variable "metrics" {
  description = "List of metrics to collect"
  type = list(object({
    category = string
    enabled  = bool
  }))
  default = []
}