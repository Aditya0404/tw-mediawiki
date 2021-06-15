# tw-mediawiki


This Project sets up Mediawiki with just one command

Following are the Prerequisites:

1. Terraform should be installed and should have access to provision infrastructure (either using Secret keys or AWS IAM Role).
2. Ansible should be installed on the host from where you want to run the Project.
3. You should have the .pem file downloaded on the system to ssh into the ec2-instance created (Required only to Launch EC2).


## Installation

Step 1. Clone this Repository

Step 2. In main.tf, change the Following:
  * private_key_path to the location of your key file. It is currently set to "/Users/Aditya/Downloads/poc-account.pem"
  * vpc_id to the vpc id of your aws account. It is currently set to "vpc-dce668a1".
  * subnet_id to the subnet in which you want to launch this ec2. It is currently set to "subnet-78730c27".
  * key_name to name of your ssh key. It is currently set to "poc-account".
  * If you want to change the region, you can change it under provider block. You will have to change the ami-id also, if you change the region.

Step 3 (optional): If you want to change the password for root user and wiki user, you can change it in the script "mysql_secure_script.sh". Currently, it is set to "password"
Step 3. Initialize the Terraform

```bash
terraform init
```

Step 4. Running Terraform Apply

```bash
terraform apply
```

## Screenshots:

![Alt text](./screenshots/t1.png?raw=true "Terraform and Ansible in action")

![Alt text](./screenshots/t2.png?raw=true "Terraform and Ansible in action")

![Alt text](./screenshots/t3.png?raw=true "Terraform and Ansible in action")

![Alt text](./screenshots/t4.png?raw=true "Terraform and Ansible in action")

![Alt text](./screenshots/app1.png?raw=true "Terraform and Ansible in action")

![Alt text](./screenshots/app2.png?raw=true "Terraform and Ansible in action")

![Alt text](./screenshots/app3.png?raw=true "Terraform and Ansible in action")
