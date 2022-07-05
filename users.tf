resource "zia_admin_users" "Zscaler_SE" {
    login_name                  = "zscaler.se@hoxiezscaler.com"
    user_name                   = "Zscaler.SE"
    email                       = "zscaler.se@hoxiezscaler.com"
    is_password_login_allowed   = true
    password                    = "InTheCloud2021!"
    role {
        id = data.zia_admin_roles.super_admin.id
    }
    admin_scope {
        type = "DEPARTMENT"
        scope_entities {
            id = [data.zia_department_management.engineering.id]
        }
    }
}

data "zia_admin_roles" "super_admin" {
  name = "Super Admin"
}

data "zia_department_management" "service_admin" {
  name = "Service Admin"
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "spot-instance"

  create_spot_instance = true
  spot_price           = "0.60"
  spot_type            = "persistent"

  ami                    = "ami-ebd02392"
  instance_type          = "t2.micro"
  key_name               = "user1"
  monitoring             = true
  vpc_security_group_ids = ["sg-12345678"]
  subnet_id              = "subnet-eddcdzz4"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

repos:
  - repo: https://github.com/ZscalerCWP/iac-pre-commit-hooks
  rev: v0.0.1
  hooks:
  - id: iac-scanner-pre-commit