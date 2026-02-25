locals {
  instance_type = "t2.small"
  ami_id = "ami-0220d79f3f480ecf5"
  name = "${var.project}-${var.pro}"
  tags = merge(
    var.common_tags,
    {
        Name = "${local.name}-local-demo"
    }
  )

}