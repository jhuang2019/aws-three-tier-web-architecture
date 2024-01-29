# aws-three-tier-web-architecture

This repo is used to build high availability and scalability web applications.

The web architecture consists of three tiers, including web tier, application tier and database tier.

## References

* AWS General Immersion Day workshop: <https://catalog.workshops.aws/general-immersionday/en-US>
* <https://github.com/aws-samples/aws-three-tier-web-architecture-workshop>

## The AWS services I used

EC2,VPC,IAM,Cloud Watch, RDS

## The architecture diagram

The below diagram is from the first reference site (AWS General Immersion Day workshop) above
![Alt text](./images/overall-diagram.png)

## 1. Prerequisites

* Create a new aws account
* Create an IAM user in the new aws account created above with the details below.
  * User Name: Administrator
  * Custom password: Create your own password
  * Attach policies directly with the policy name called `AdministratorAccess`
* The following parts are implemented in the IAM user account created above.

## 2. Network - Amazon VPC

* Create a VPC in the region `Asia Pacific (Sydney)` with the following details.
  * Name: VPC-Lab
  * IPv4 CIDR block: `10.0.0.0/16`
  * Availability Zones: 2
  * Customize AZs: `ap-southeast-2a` and `ap-southeast-2c`
  * Number of public subnets: 2
  * Number of private subnets: 2
  * Customize subnets CIDR blocks with the following values.
  
    |         KEY                   |   VALUE           |
    | :---------------------------: |:-----------------:|
    | 2a Public subnet's IPv4 CIDR  | 10.0.10.0/24      |
    | 2c Public subnet's IPv4 CIDR  | 10.0.20.0/24      |
    | 2a Private subnet's IPv4 CIDR | 10.0.100.0/24     |
    | 2c Private subnet's IPv4 CIDR | 10.0.200.0/24     |
  * NAT gateways: In 1 AZ
  * VPC endpoints: None
  * DNS options: Enable DNS hostnames and Enable DNS resolution
  
## 2. Compute - Amazon EC2

### 2.1 Launch a web instance and execute user data

* Name: Web server for custom AMI
* Amazon Machin Image: Amazon Linux AWS (by default) and select `Amazon Linux 2023 AMI`
* Architecutre: 64-bit (x86)
* Instance type: t2.micro
* Key pair name: Proceed without a key pair
* VPC: VPC-Lab-vpc
* Subnet: VPC-Lab-subnet-public1-ap-southeast-2a
* Auto-assign Public IP: Enable
* Create a security group with the following details.
  * Security group name: Immersion Day - Web Server
  * Description: Immersion Day - Web Server
  * Add security group rule in the inbound rules: set HTTP to Type. Allow TCP/80. Select 0.0.0.0/0 for the Custom source type.
  * Advanced details (Meta Data versions): V2 only (token required)
  * User data

   ```bash script
    #!/bin/sh
    ​
    #Install a LAMP stack
    dnf install -y httpd wget php-fpm php-mysqli php-json php php-devel
    dnf install -y mariadb105-server
    dnf install -y httpd php-mbstring
    ​
    #Start the web server
    chkconfig httpd on
    systemctl start httpd
    ​
    #Install the web pages for our lab
    if [ ! -f /var/www/html/immersion-day-app-php7.zip ]; then
    cd /var/www/html
    wget -O 'immersion-day-app-php7.zip' 'https://static.us-east-1.prod.workshops.aws/public/dd38a0a0-ae47-43f1-9065-f0bbcb15f684/assets/immersion-day-app-php7.zip'
    unzip immersion-day-app-php7.zip
    fi
    ​
    #Install the AWS SDK for PHP
    if [ ! -f /var/www/html/aws.zip ]; then
    cd /var/www/html
    mkdir vendor
    cd vendor
    wget https://docs.aws.amazon.com/aws-sdk-php/v3/download/aws.zip
    unzip aws.zip
    fi
    ​
    # Update existing packages
    dnf update -y

   ```

### 2.2 Create a custom Amazon Machine Image (AMI)

In the EC2 console,select the instance that we created earlier in the step 2.1 above, click Actions > Image and templates > Create Image

* image name: Web Server v1
* image description: LAMP web server AMI
  
### 2.3 Launch an Applcation Load Balancer (ALB)

Create a target group with the following details.

* target type: Instances
* target group name: web-TG
* VPC: VPC-Lab-vpc

Create an appllication load balancer with the following details.

* load balancer name: Web-ALB
* VPC: VPC-Lab-vpc
* Subnets: VPC-Lab-subnet-public1-ap-southeast-21 and VPC-Lab-subnet-public2-ap-southeast-2c
* Create a new security group with the details below and attach it to the ALB. Remove the default security group.
  * security group name: web-ALB-SG
  * description: web-ALB-SG
  * VPC: VPC-Lab-vpc
  * Add an inbound rule with http type and Anywhere-IPv4 as the source
* Listeners and routing: Use the target group `web-TG` created above.
  
### 2.4 Configure a Launch Template

Create a security group with the followig details.

* security group name: ASG-Web-Inst-SG
* Description: HTTP Allow
* VPC: VPC-Lab-vpc
* Add an inbound rule with the Type HTTP and the security group `web-ALB-SG`. This will configure the security group to only receive HTTP traffic coming from ALB.

Create a launch template with the following details.

* launch template name: web
* template version description: Immersion Day Web Instances Template - Web only
* Auto scaling guidance: Cick the checkbox `Provide guidance to help me set up a template that I can use with EC2 Auto Scaling`
* AMI: Web Server v1 which was created in 2.2 above
* instance type: t2.micro
* security group: ASG-Web-Inst-SG
* Create a resouce type with the following details.
  
|      KEY       |      VALUE            |
| :------------: |:---------------------:|
| Key            | Name                  |
| Value          | Web Instance          |
| Resource types | Instances and Volumes |


### 2.5 Configure an Auto Scaling Group

### 2.6 Test auto scaling and change manual settings

## 3. Database - Amazon Aurora


## 4. Clean up resources






