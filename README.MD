# AWS EC2 TF

This code will create a little infrastructure in AWS with:

* One VPC with address 192.168.0./24 (can be modified)
* Two Subnets (192.168.0.0/25 and 192.168.0.128/25)
* One Internet Gateway and Route Tables
* On or more EC2 of type T2.micro (Elegible on Free Tier)
* SSH keys to access

Almost all dymamic data can be modified through the files "local.tf" and variables.tf inside of the modules directory.


Important: To access Instance per SSH, use the script "Key Gen" in the root patch. Remeber of change the variable name in the function file() on the file main in ec2 module. 