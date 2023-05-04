# Github Actions Workflow Examples

Here are four examples of CI workflows that run Chef Test Kitchen in the github runners. There is a matching kitchen.xxx.yml in the root of the repository that drives the kitchen test

Rename (or copy) the content from any of the following examples into the ci.yml and push the new version.

## ci.yml.azure

This is my favorite example. This utilizes the Azure configuration in the secrets of the Repository Settings. You'll need the following:

* SUBSCRIPTION_ID
* CLIENT_ID
* CLIENT_SECRET
* TENANT_ID

Enter those into a New Repository Secret with their values. If you use Azure locally for kitchen testing, they will be in your '~/.azure/credentials' folder.

This one is the one I test against the most number of OSes. More can be added of course if you know the Azure Image URN.

### Benefits of Azure

* Likely the fastest provisioning and testing on Windows platforms
* Ability to test against Windows Workstations (Windows 10 / 11). There are lots of variants of this, so be sure to check the Image URN for what you want. Some of them are locked down from a WinRM perspective so can sometimes be challenging to get the connectivity right. (See the kitchen.azure.yml for the Windows 10 / 11 eaxmples!)

### Concerns of Azure

* The biggest one is probably that you need privileges to provision on Azure. This can always be a difficult discussion.
* Make SURE that you Destroy these or have a method to "reap" or clean unused instances.
  * You will see in the kitchen.azure.yml example that we are prefixing the nodes with GA-Chef_Client (meaning github actions / chef client) so I can find them in the Resource Group.
  * Also there is an xTTL tag that we use to set an end of life date with a tool called Reaper that goes and deletes all resources with that tag when it expires. These I have set for 2 hours.
* Cost (to some degree) but as long as you have the above configured, cost is going to be pretty minimal.

## ci.yml.exec

This is an example of Local Exec testing. This will provision runners and execute the kitchen test on those runners directly.

### Benefits of Exec

* If you need to test against MacOS, this is about the best way to do it.

### Concerns of Exec

* These systems are bandwidth limited and installing the Chef Workstation and Client, especially on Windows, can take a little bit of time (8 - 10 minutes).

## ci.yml.vagrant

Utilizing the Vagrant method, it will create a MacOS Runner which has included VirtualBox and Vagrant. ()
