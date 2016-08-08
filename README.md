# java-dev-vsts

The Java Dev VSTS labs use a pre-built virtual machine image.  To use the labs, you will run a copy of this image in your own Azure subscription.

Instead of manually creating the resources in Azure, we are going to use Azure Resource Management (ARM) templates.

**Tasks**

1. Provision the Storage Account
2. Use AzCopy to Create a Copy of the Lab VM Image
3. Provision the VM and Dependent Resources


## Task 1: Provision the Storage Account
    
1. Create a new storage account.
    
    Simply click the Deploy to Azure button below and follow the wizard to create a storage account. You will need to log in to the Azure Portal.
                                                                     
	<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fnwcadence%2Fjava-dev-vsts%2Fmaster%2FJavaDevVSTS-Storage.json" target="_blank">
		<img src="http://azuredeploy.net/deploybutton.png"/>
	</a>
	<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fnwcadence%2Fjava-dev-vsts%2Fmaster%2FJavaDevVSTS-Storage.json" target="_blank">
		<img src="http://armviz.io/visualizebutton.png"/>
	</a>

    The storage account will be deployed to a Resource Group. You can delete the resource group in order to remove all the created resources at any time.

1. Specify settings for the deployment
    
    You will need to select a subscription and region to deploy the Resource Group to.

    ![](<media/1.jpg>)

1. Check the Resource Group in the Azure Portal
    When the deployment completes, you should see the following resources in the Azure Portal:

    ![](<media/2.jpg>)


## Task 2: Use AzCopy to Create a Copy of the Lab VM Image

1. Download and install AzCopy

	Download and install the latest version of AzCopy from here: http://aka.ms/downloadazcopy

1. Obtain your storage account access key.

	In the Azure portal, go to your storage account settings tab
	Click Access Keys
	Copy the primary storage key

1. Run the following AzCopy command substituting your own values for the storage account name and key.

	"%PROGRAMFILES(x86)%\Microsoft SDKs\Azure\AzCopy\AzCopy.exe" /Source:https://vstsjl2016vhd.blob.core.windows.net/vhd /Pattern:"vstsjlvhd072216.vhd" /Dest:YOUR_STORAGE_ACCOUNT_URI /DestKey:YOUR_STORAGE_ACCOUNT_KEY

	YOUR_STORAGE_ACCOUNT_URI - should be in the format of https://YOUR_STORAGE_ACCOUNT_NAME.blob.core.windows.net/vhd

	It will take approximately 10 minutes to copy the image to your storage account.


## Task 3: Provision the VM and Dependent Resources

1. Create the VM and dependent resources.
    
    Simply click the Deploy to Azure button below and follow the wizard to create the resources. You will need to log in to the Azure Portal.
                                                                     
	<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fnwcadence%2Fjava-dev-vsts%2Fmaster%2FJavaDevVSTS-VM.json" target="_blank">
		<img src="http://azuredeploy.net/deploybutton.png"/>
	</a>
	<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fnwcadence%2Fjava-dev-vsts%2Fmaster%2FJavaDevVSTS-VM.json" target="_blank">
		<img src="http://armviz.io/visualizebutton.png"/>
	</a>

    The resources will be deployed to a Resource Group. You can delete the resource group in order to remove all the created resources at any time.

1. Specify settings for the deployment
    
    You should select the same subscription and Resource Group where you deployed your storage account to.

	Provide a public DNS name

	Provide the URI to the vhd which should look like this: https://YOUR_STORAGE_ACCOUNT_NAME.blob.core.windows.net/vhd/vstsjlvhd072216.vhd

    ![](<media/1.jpg>)

1. Check the Resource Group in the Azure Portal
    When the deployment completes, you should see the following resources in the Azure Portal:

    ![](<media/2.jpg>)