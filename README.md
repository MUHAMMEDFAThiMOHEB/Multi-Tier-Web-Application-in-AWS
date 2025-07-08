# Multi-Tier-Web-Application-in-AWS
Deploy a custom VPC for a Multi-Tier Web Application hosted in AWS

This is the copstone project as the end of my journy of learning Terraform

# Project Diagram

![Terraform_Capstone_Project_Diagram](./Assets/Diagram%20picture.png)

# AWS Solution Architecture Diagram Description

This diagram illustrates a robust, multi-tier web application architecture deployed within a custom Amazon Web Services (AWS) Virtual Private Cloud (VPC). The design emphasizes high availability across multiple Availability Zones, automatic scaling, and secure network segmentation.

# Key Components and Services:

1.  **Region (`eu-central-1`)**
    * **Description:** The entire solution is deployed within a specific AWS Region, indicated as `eu-central-1` (Frankfurt). This region serves as the geographical area for all deployed resources.

2.  **VPC (`VPC CIDR 10.0.0.0/16`)**
    * **Description:** A custom Virtual Private Cloud (VPC) with a CIDR block of `10.0.0.0/16` forms the isolated network environment for all resources. This custom VPC provides full control over the network configuration.

3.  **Availability Zones (`eu-central-1a`, `eu-central-1b`)**
    * **Description:** The architecture leverages two distinct Availability Zones (AZs) within the specified region (`eu-central-1a` and `eu-central-1b`). Deploying resources across multiple AZs ensures high availability and fault tolerance in case one AZ experiences an outage.

4.  **Subnets**
    * **Description:** The VPC is segmented into six subnets distributed across the two Availability Zones to enforce network isolation and security:
        * **Public Subnets (2):** One in `eu-central-1a` (Public subnet 1) and one in `eu-central-1b` (Public subnet 2). These subnets host resources that require direct internet access, such as NAT Gateways.
        * **Private Subnets (4):** Two in `eu-central-1a` (Private subnet 1, Private subnet 3 "Reserved for DB") and two in `eu-central-1b` (Private subnet 2, Private subnet 4 "Reserved for DB"). These subnets host application servers and database instances, preventing direct internet access for enhanced security.

5.  **Internet Gateway (IGW)**
    * **Description:** The Internet Gateway provides a connection between the VPC and the public internet. It enables public subnets to communicate with the internet and allows inbound internet traffic to the ALB.

6.  **Router**
    * **Description:** Within the VPC, the Router (represented by the purple double-arrow icon) handles all routing of network traffic between subnets and to/from the Internet Gateway and NAT Gateways.

7.  **NAT Gateways (`NAT gateway 1`, `NAT gateway 2`)**
    * **Description:** Two Network Address Translation (NAT) Gateways are deployed, one in each public subnet (`NAT gateway 1` in Public subnet 1, `NAT gateway 2` in Public subnet 2). NAT Gateways enable instances in private subnets to initiate outbound connections to the internet (e.g., for software updates, external API calls) without exposing them to inbound internet traffic.

8.  **Application Load Balancer (ALB)**
    * **Description:** The ALB distributes incoming application traffic across multiple targets, such as EC2 instances. It operates at the application layer (Layer 7) and provides advanced routing features. The ALB receives traffic from the internet and forwards it to the appropriate target group.
    * **Security Group for ALB:** (Implicitly attached) The ALB would have its own Security Group (`ALBSG` as per requirements) to control inbound HTTP traffic.

9.  **Target Group (`Target group`)**
    * **Description:** The Target Group acts as a logical grouping for the EC2 instances that the ALB distributes traffic to. It performs health checks on the registered instances and only forwards traffic to healthy ones. This component decouples the ALB from individual instances, enabling seamless scaling and instance replacement.

10. **EC2 Instances (`EC2_1`, `EC2_2`)**
    * **Description:** Two EC2 instances (`EC2_1` in Private subnet 1, `EC2_2` in Private subnet 2) serve as the application servers. These instances are EBS-backed and are the targets for the Application Load Balancer via the Target Group.
    * **Security Groups for EC2:** Each EC2 instance is associated with a "Security group" (`WebSG` as per requirements), which acts as a virtual firewall allowing specific inbound traffic (SSH, HTTP) and all outbound traffic.

11. **Auto Scaling Group (`Auto Scaling group`)**
    * **Description:** The Auto Scaling Group dynamically manages the number of EC2 instances based on defined policies (e.g., CPU utilization). It ensures application availability and automatically scales the number of instances up or down to handle changes in demand. The instances (`EC2_1`, `EC2_2`) are part of this group, indicating they are managed for scalability and resilience.

12. **Launch Template (`Launch Template`)**
    * **Description:** This is a configuration blueprint used by the Auto Scaling Group to launch new EC2 instances. It specifies all the details required to create an instance, including the Amazon Machine Image (AMI), instance type, associated Security Groups (e.g., `WebSG`), and any user data scripts that run upon launch. This ensures consistency for all instances provisioned by the ASG.

# Project File System:

![Project_File_System](./Assets/Project%20File%20System.png)