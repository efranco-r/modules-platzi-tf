variable "ami_id" {
	default=""
	description="AMI Id"
	type=string	
}
variable "instance_type" {
	default=""
	description="Instance type t2.micro"
	type=string	
}
variable "tags" {
	description="Instance type t2.micro"
	type=map	
}
variable "sg_name" {
	default=""
	description="Security group platzi test"
	type=string
}
variable "ingress_rules" {
	description="Ingress platzi test"
	type=list
}
variable "egress_rules" {
	description="Egress platzi test"
	type=list
}