env              = "dev"
bastion_cidr     = ["172.31.93.66/32"]
default_vpc_id   = "vpc-063bfcfb7f8faec35"
default_vpc_cidr = "172.31.0.0/16"
default_vpc_rtid = "rtb-0f4cf25785f56057f"
kms_arn          = "arn:aws:kms:us-east-1:878756956432:key/c770d687-27ad-4188-b4b0-c3d4ce34a454"
vpc = {
  main = {
    cidr_block = "10.0.0.0/16"
    subnets = {
      public = {
        name       = "public"
        cidr_block = ["10.0.0.0/24", "10.0.1.0/24"]
        azs        = ["us-east-1a", "us-east-1b"]
      }
      webserver = {
        name       = "webserver"
        cidr_block = ["10.0.2.0/24", "10.0.3.0/24"]
        azs        = ["us-east-1a", "us-east-1b"]
      }
      application = {
        name       = "application"
        cidr_block = ["10.0.4.0/24", "10.0.5.0/24"]
        azs        = ["us-east-1a", "us-east-1b"]
      }
      database = {
        name       = "database"
        cidr_block = ["10.0.6.0/24", "10.0.7.0/24"]
        azs        = ["us-east-1a", "us-east-1b"]
      }
    }
  }
}

application = {
  frontend = {
    name             = "frontend"
    instance_type    = "t3.small"
    subnet_name      = "webserver"
    desired_capacity = 2
    max_size         = 5
    min_size         = 2
    allow_app_cidr   = "public"

  }
  catelogue = {
    name             = "catalogue"
    instance_type    = "t3.micro"
    subnet_name      = "application"
    desired_capacity = 2
    max_size         = 5
    min_size         = 2
    allow_app_cidr   = "webserver"
  }
  # cart = {
  #   name = "cart"
  #   instance_type = "t3.micro"
  #   subnet_name = "application"
  # }
  # user = {
  #   name = "user"
  #   instance_type = "t3.micro"
  #   subnet_name = "application"
  # }
  # shipping = {
  #   name = "shipping"
  #   instance_type = "t3.micro"
  #   subnet_name = "application"
  # }
  # payment = {
  #   name = "payment"
  #   instance_type = "t3.micro"
  #   subnet_name = "application"
  # }
}

docdb = {
    main = {
      subnet_name    = "database"
      allow_db_cidr  = "application"
      engine_version = "4.0.0"
      instance_count = 1
      instance_class = "db.t3.medium"
    }
}

rds = {
    main = {
      subnet_name    = "database"
      allow_db_cidr  = "application"
      engine_version = "5.7.mysql_aurora.2.11.2"
      instance_count = 1
      instance_class = "db.t3.small"
    }
}
