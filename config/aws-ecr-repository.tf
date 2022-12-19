resource "aws_ecr_repository" "identity-svc-ecr" {
  name                 = "identity-svc-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "application-svc-ecr" {
  name                 = "application-svc-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
