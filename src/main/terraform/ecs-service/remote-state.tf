# Load in VPC state data for subnet placement
data "terraform_remote_state" "vpc" {
  backend = "s3"

  config {
    bucket = "${var.remote_state_bucket_name}"
    key    = "vpc/terraform.tfstate"
    region = "${var.region}"
  }
}

# Load in VPC security groups to reference db sgs
data "terraform_remote_state" "vpc_security_groups" {
  backend = "s3"

  config {
    bucket = "${var.remote_state_bucket_name}"
    key    = "security-groups/terraform.tfstate"
    region = "${var.region}"
  }
}

#TODO remove this and add explicit outbound rules as part of security hardening ticket ALS-500
#SPG Common Security Groups & Rules (Used for common outbound rules
data "terraform_remote_state" "security-groups-and-rules" {
  backend = "s3"

  config {
    bucket = "${var.remote_state_bucket_name}"
    key    = "spg/security-groups-and-rules/terraform.tfstate"
    region = "${var.region}"
  }
}


# Load in shared ECS cluster state file for target cluster arn
data "terraform_remote_state" "ecs_cluster" {
  backend = "s3"

  config {
    bucket = "${var.remote_state_bucket_name}"
    key    = "spg/common_stack/ecs-cluster/terraform.tfstate"
    region = "${var.region}"
  }
}

# Load in LDAP (apacheds) state for ldap connectivity details
data "terraform_remote_state" "delius_ldap" {
  backend = "s3"

  config {
    bucket = "${var.remote_state_bucket_name}"
    key    = "delius-core/application/ldap/terraform.tfstate"
    region = "${var.region}"
  }
}
