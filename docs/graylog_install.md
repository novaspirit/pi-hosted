# Install and setup instructions for the Graylog Server

## Introduction

[Graylog](https://www.graylog.org) is a centralized logging solution that allows the user to aggregate and search through logs. It provides a powerful query language, a processing pipeline for data transformation, alerting abilities, and much more.

## Screenshot

![image](https://user-images.githubusercontent.com/42878642/187014416-ffa2e0bd-2e05-4f8b-a3e9-7d04d1572943.png)

# Installation

## Pre-Installation Steps

First find Graylog in the listing of templates from the project.

![image](https://user-images.githubusercontent.com/42878642/187007649-190e8d99-6e94-4405-a8d0-dcaabb46e5e9.png)

## Set all variables

![image](https://user-images.githubusercontent.com/42878642/187009036-35386396-4663-4565-a208-5daeb1c5c2cd.png)

- `GRAYLOG_PASSWORD_SECRET`: At least a 16 character password is required.
- `GRAYLOG_HTTP_EXTERNAL_URI`: This is the URI where you'll connect to the instance after its up and running. It is very important to include the trailing /.  It should be formatted as `http://192.168.1.1:7555/`

Once done, just click `Deploy the stack`.

Keep in mind this process of deployment will take roughly 10 minutes to complete, and you will see the sys load variable on your Pi move into the red.  Let it sit and process.

## Connection Test

Once the servers are deployed and showing as up (running) you should be able to head to http://192.168.1.10:7555/ in your browser and you'll be greated by the login screen

![image](https://user-images.githubusercontent.com/42878642/187014060-412a8858-54b2-4a22-abd3-de614da6befd.png)

Username: admin </br>
Password: admin

I suggest you change this immediately unless you only plan to run this behind your firewalls with no external access.  You have been warned.
