# Terraform

its a cloud based automation purpose. 

By using this we can create our resource using which ever cloud environment we want we can create our self using this Terrform.

it mainly devoloped on go launguage. and its extension is .tf.

by using this terraform Automation we can work with multiple cloud environments.

me also manily using this terraform for Aws and Azure Cloud environment.

and also we have a modules in terraform 



![1_lYFNHNM03biX_95IQMayUw](https://user-images.githubusercontent.com/38804803/60717775-7cadd080-9f40-11e9-89c9-4f9f2f318450.png)


                                install Terraform on Ubuntu 16.04
  To update the system and packages, you can use the built-in software updater, or manually update the system with:
     
            $ sudo apt-get update
 
 Again, we will install wget and unzip packages if they’re not already installed:
                       
            $ sudo apt-get install wget unzip

 Also next, we will run the same commands as we did with ubuntu 14.04:

            $ wget https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip

            $ sudo unzip ./terraform_0.11.13_linux_amd64.zip -d /usr/local/bin/

 And finally, to test if our installation was successful:

            $ terraform -v
