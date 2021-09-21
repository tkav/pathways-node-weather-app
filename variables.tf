variable "bucket" {
  type        = string
  description = "Specifies the name of an S3 Bucket"
  default     = "tkav-pathways-dojo"
}

variable "tags" {
  type        = map(string)
  description = "Use tags to identify project resources"
  default     = {}
}