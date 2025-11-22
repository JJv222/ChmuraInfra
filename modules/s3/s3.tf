resource "aws_s3_bucket" "b" {
  bucket = "${var.project_name}-bucket-JA263855"

  tags = {
    Name        = "${var.project_name}-s3-bucket"
  }
}