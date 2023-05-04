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

## 