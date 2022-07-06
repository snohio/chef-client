# chef-client CHANGELOG

This file is used to list changes made in each version of the chef-client cookbook.

## 1.2.0

- Moved the date stamp function to it's own recipe to make walk throughs easier.

## 1.1.1

- Someone asked how to record when the client was created in an attribute.

> The file to check the date on is in the attributes/default. You can change it from pem to .rb or put an override in your kitchen.yml file for pipelines. Linux tk builds have the client.rb in the right path. Windows is actually stored in `c:\users\azure\AppData\Local\Temp\kitchen`

## 1.0.0

Initial release.

- Nothing amazing here except it is the initial release
- Times and such are hardcoded for 5 minutes
