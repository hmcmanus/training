CloudFormation 101
==================

# About this repository

This repository contains three key sections.

- `./presentation` is a HTML based presentation to guide you through the training session
- `./src/exercise-*` contains the supporting material, referenced in the presentation
- `./src/setup` contains information about preparing the training session

# Objectives

This repository is intended to be a primer on the use of AWS CloudFormation for the automatic creation of AWS resources.
Assumptions are: Little to no AWS experience prior to the session.

# Prerequisites

* An AWS account with a user that can execute CloudFormation stacks (along with EC2 & SQS)
* A basic knowledge of JSON
* A ssh public key to ssh to an ec2 instance

# Setup Instructions

## Simple (for one person)
For the exercises to work you'll need a few basic supporting components (VPC, Subnet, Security Group). AWS provides these by default so you could skip the setup if you're only interested in completing the exercises yourself.

## Advanced (to run your own demos)
If you'd like to run the exercises for others, we've provided a CloudFormation template that creates the required VPC, Subnet, Security Group and Jumpbox. Create the supporting stack by doing the following:

- Logging into AWS https://signin.aws.amazon.com/console/
- then selecting `Servces > CloudFormation > Create Stack`.
- Choosing the template `./scr/setup/cf101-vpc.template`,
- then giving your stack a name,
- then suppling a valid AWS KeyName (a Public key you've uploaded to AWS).
- Also, make sure you choose an appropriate instance `EC2InstanceType`. `t2.small` is a good choice if you're not sure.
- Continue with the defaults for everything else.

This will create a VPC (an isolated network for us to play in) and Jumpbox (a virtual machine that we'll use as an entry point to login to other machines via ssh). This is a common pattern for AWS and other networks.

If you're intended on having others follow the exercises you'll want to manage ssh users and keys on the jumpbox. There's a script `./src/setup/create_user.sh` that has been supplied to handle this for you if you update the `S3_URL` variable to point to an S3 Bucket with the public keys. You can then run this script on the Jumpbox.

# Exercises

In your browser open the [Presentation](presentation/index.html) and follow along.