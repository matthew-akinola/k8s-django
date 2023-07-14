resource "aws_s3_bucket" "django_bucket" {
  bucket = "techmattbucket"

  tags = {
    Name = "My bucket"
  }
}