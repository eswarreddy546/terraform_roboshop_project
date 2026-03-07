variable "project_name" {
    default = "roboshop"
}

variable "environment" {
    default = "dev"
}


variable "sgvalues" {
    default =[
        "mongodb","reddis","mysql","rabbitmq",
        "catalogue","shipping","user","cart","payment",
        "frontend",
        "bastionhost",
         "frontend_alb",
         "backend_alb","frontend_alb_certificate_arn"



        
        ]
  
}