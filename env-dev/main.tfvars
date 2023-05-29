env = "dev"
bastion_cidr = ["172.31.93.66/32"]
vpc = {
  main = {
    cidr_block = "10.0.0.0/16"
    subnets = {
      public = {
        name = "public"
        cidr_block = ["10.0.0.0/24", "10.0.1.0/24"]
        azs = ["us-east-1a", "us-east-1b"]
      }
      webserver = {
        name = "webserver"
        cidr_block = ["10.0.2.0/24", "10.0.3.0/24"]
        azs = ["us-east-1a", "us-east-1b"]
      }
      application = {
        name = "application"
        cidr_block = ["10.0.4.0/24", "10.0.5.0/24"]
        azs = ["us-east-1a", "us-east-1b"]
      }
      database = {
        name = "database"
        cidr_block = ["10.0.6.0/24", "10.0.7.0/24"]
        azs = ["us-east-1a", "us-east-1b"]
      }
    }
  }  
}

application = {
  frontend = {
    name = "frontend"
    instance_type = "t3.small"
    subnet_name = "webserver"
    desired_capacity   = 2
    max_size           = 5
    min_size           = 2
    allow_app_cidr     = "public"

  }
  catelogue = {
    name = "catalogue"
    instance_type = "t3.micro"
    subnet_name = "application"
    desired_capacity   = 2
    max_size           = 5
    min_size           = 2
    allow_app_cidr     = "webserver"
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