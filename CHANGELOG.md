# chef-client CHANGELOG

This file is used to list changes made in each version of the chef-client cookbook.

## 1.5.0

- Moving Linux recipe to use systemd rather than cron.
  - This is apparently the new pattern that we want to set going forward for all linux systems that support systemd\
  - Updated the Inspec test to match

## 1.4.1

- Added attributes for compliance to the Attributes. This was required for running the compliance phase in the berks model.

## 1.4.0

- Tested against Client 18 and passed
- Added dependency on chef_client_updater
  - Checks to see what version should be installed
  - Upgrades to latest if desired version is > current version (Work still needed)

## 1.3.2 + Falling Forward

- Returning to function like 1.3.1. You can actually modify the client.rb temporarily to do this now

## 1.3.1

- Testing a json out on a full client run

## 1.3.0

- Changed Copyright date
- Added recipe to hard set the policy group and file in the client.rb for testing.

## 1.2.0

- Moved the date stamp function to it's own recipe to make walk-throughs easier.

## 1.1.1

- Someone asked how to record when the client was created in an attribute.

> The file to check the date on is in the attributes/default. You can change it from pem to .rb or put an override in your kitchen.yml file for pipelines. Linux tk builds have the client.rb in the right path. Windows is actually stored in `c:\users\azure\AppData\Local\Temp\kitchen`

## 1.0.0

Initial release.

- Nothing amazing here except it is the initial release
- Times and such are hardcoded for 5 minutes
