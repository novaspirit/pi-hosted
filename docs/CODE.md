# Install and setup instructions for Collabora Online Development Edition (CODE) and using it with NextCloud

## Introduction

Collabora Online is a powerful online office suite which you can integrate into your own infrastructure, it will allow you to open and edit documents from within your NextCloud environment. You should point a domain to your CODE instance.

## Installation

From the Docker template you will need to fill in:
- `server_name` with the domain of your CODE instance, for example `collabora.mydomain.com`
- `domain` with the domain of your NextCloud instance, for example `nextcloud\.mydomain\.com|test\.mydomain\.com|nc\.mydomain\.com`
- `DONT_GEN_SSL_CERT` should have something in such as `true` or `1`
- `extra_params` should be set as `--o:ssl.enable=false --o:ssl.termination=true`

Additionally you can set:
- `admin` as the administrator name you wish to use for the admin console, this is not something we will expose or you will need to access.
- `password` as the administrator password you wish to use for the admin console, this is not something we will expose or you will need to access.
- `dictionaries` by default only limited set of spelling dictionaries and thesauri are configured for CODE, mainly for performance reasons. The default set of languages is the following: de_DE en_GB en_US es_ES fr_FR it nl pt_BR pt_PT ru. With the dictionaries environment variable you can change this list. The dictionaries environment variable should contain the space separated list of language codes (optionally followed by country code). In order to save resources, it makes sense to load only those dictionaries that are actually needed.
- `cert_domain` is unnecessary, when this environment variable is set (is not “”), then startup script will generate a new SSL certificate signed by a dummy CA for this domain, not for localhost

## Setting up NextCloud

You will need to install the app `Nextcloud Office`, then navigate to `Office` from within the `Administration settings`.

Click `Use your own server` and enter the domain of your CODE instance in the `URL` field and click `Save`

If NextCloud states Collabora Online server is reachable then you are all set.
