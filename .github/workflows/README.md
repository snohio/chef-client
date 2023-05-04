# Github Actions Workflow Examples

Here are four examples of CI workflows that run Chef Test Kitchen in the github runners. There is a matching kitchen.xxx.yml in the root of the repository that drives the kitchen test

Rename (or copy) the content from any of the following examples into the ci.yml and push the new version. See Mix and Match at the bottom of this doc.

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
* Ability to test against Windows Workstations (Windows 10 / 11). There are lots of variants of this, so be sure to check the Image URN for what you want. Some of them are locked down from a WinRM perspective so can sometimes be challenging to get the connectivity right. (See the kitchen.azure.yml for the Windows 10 / 11 examples!)

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

Utilizing the Vagrant method, it will create a MacOS Runner which has included VirtualBox and Vagrant. (Side note: I find is funny that you can use Github's MacOs runner with VB and Vagrant, but can't on a M1 chip.)

### Benefits of Vagrant

* If you are used to running Vagrant and VirtualBox for local testing, this would be the most straight forward way for continuity.
* You can use the stromweld Windows platforms from BentoBox.

### Concerns of Vagrant

* S L O W - Mostly for Windows. My checks were running about 15 minutes on Windows.

## ci.yml.dokken

Besides being metal, this is your quickest test suite. Not sure what else to say here. It works on a Ubuntu runner.

### Benefits of Dokken

* Blazing fast results.

### Concerns of Dokken

* Limited by OSes available in a container (meaning no Windows or Mac)
* Results MAY vary if installing applications and validating they are installed. For this `chef-client` cookbook, it does not return that Chef is installed and has the correct version.

## Mix and Match

Feel free to take these examples of the different options and mix and match what fits your needs. In my final ci.yml I have done that so that I can include MacOS in my testing suite. It does mean that there is more to update as needed (such as client version) because those kitchen.xxx.yml files all need updated. 

## In Conclusion

This was probably the most fun of an exercise I have engaged in this year. It has been on my To Do list for awhile and I've been scared of it. With just a little help, I've really discovered the power of Github Actions and it is very cool what can be done.

Shout Out to Jason Field and Dan Webb who's actions are utilized in these examples. Please check out their [Actions Hub Org](https://github.com/actionshub) on GitHub as well as contribute to their efforts on [Open Collective](https://opencollective.com/actionshub) and [Corey Hemminger](https://github.com/stromweld) for holding my hand through this exercise.
