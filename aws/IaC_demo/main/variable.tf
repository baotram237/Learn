# variable.tf file to define the variables
variable "MY_FIRST_VARIABLE" {
  type = string
  default = "Hello World"
  validation {
    condition = length(var.MY_FIRST_VARIABLE) > 0
    error_message = "The variable MY_FIRST_VARIABLE must not be empty"
  }
}

variable "MY_SECOND_VARIABLE" {
  type = number
  validation {
    condition = var.MY_SECOND_VARIABLE > 5
    error_message = "The variable MY_SECOND_VARIABLE must be greater than 5"
  }
}