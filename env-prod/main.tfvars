env              = "prod"
monitor_cidr     = ["172.31.80.62/32"]
# aws_region       = "us_east_1"
bastion_cidr     = ["172.31.13.60/32"]
default_vpc_id   = "vpc-063bfcfb7f8faec35"
default_vpc_cidr = "172.31.0.0/16"
default_vpc_rtid = "rtb-0f4cf25785f56057f"
kms_arn          = "arn:aws:kms:us-east-1:878756956432:key/c770d687-27ad-4188-b4b0-c3d4ce34a454"
domain_name      = "gilbraltar.co.uk"
domain_id        = "Z09569901LP0VHA42NP6C"

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
    desired_capacity = 1
    max_size         = 10
    min_size         = 1
    app_port         = 80
    allow_app_cidr   = "public"
    listener_priority = 1
    lb_type           = "public"
    dns_name          = "www"
    parameters        = []
    
  }
  catelogue = {
    name             = "catalogue"
    instance_type    = "t3.small"
    subnet_name      = "application"
    desired_capacity = 1
    max_size         = 10
    min_size         = 1
    app_port         = 8080
    allow_app_cidr   = "application"
    listener_priority = 1
    lb_type           = "private"
    parameters        = ["docdb"]
  }

  cart = {
    name             = "cart"
    instance_type    = "t3.small"
    subnet_name      = "application"
    desired_capacity = 1
    max_size         = 10
    min_size         = 1
    app_port         = 8080
    allow_app_cidr   = "application"
    listener_priority = 2
    lb_type           = "private"
    parameters        = ["docdb"]
  }

  shipping = {
    name             = "shipping"
    instance_type    = "t3.medium"
    subnet_name      = "application"
    desired_capacity = 1
    max_size         = 10
    min_size         = 1
    app_port         = 8080
    allow_app_cidr   = "application"
    listener_priority = 3
    lb_type           = "private"
    parameters        = ["docdb"]
  }

  payment = {
    name             = "payment"
    instance_type    = "t3.small"
    subnet_name      = "application"
    desired_capacity = 1
    max_size         = 10
    min_size         = 1
    app_port         = 8080
    allow_app_cidr   = "application"
    listener_priority = 4
    lb_type           = "private"
    parameters        = ["docdb"]
  }

  user = {
    name             = "user"
    instance_type    = "t3.small"
    subnet_name      = "application"
    desired_capacity = 1
    max_size         = 10
    min_size         = 1
    app_port         = 8080
    allow_app_cidr   = "application"
    listener_priority = 5
    lb_type           = "private"
    parameters        = ["docdb"]
  }
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
      instance_class = "db.t3.large"
    }
}

elasticache = {
    main = {
      subnet_name    = "database"
      allow_db_cidr  = "application"
      engine_version = "6.x"
      replicas_per_node_group = 1
      num_node_groups = 1
      node_type = "cache.t3.micro"
    }
}

rabbitmq = {
    main = {
      subnet_name    = "database"
      allow_db_cidr  = "application"
      instance_type = "t3.small"
    }
}

alb = {
  public = {
    name           = "public"
    subnet_name    = "public"
    allow_alb_cidr = null
    internal       = false
  }
  private = {
    name           = "private"
    subnet_name    = "application"
    allow_alb_cidr = "webserver"
    internal       = true
  }
}

