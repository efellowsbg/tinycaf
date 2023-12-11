variable "settings" {
  type = object({
    email  = string,
    github = optional(string),
  })
}
variable "ref" {
  type = string

  validation {
    condition     = can(regex("^([a-z]+_?)+[a-z]+$", var.ref))
    error_message = <<EOF
      User ref name must be all lowercase & snake_case. No numbers.
      Example:
      users = {
        john_smith = {
          email  = "john.smith@example.org"
          github = "jsmith"
        }
      }
    EOF
  }
}
