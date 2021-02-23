# MetaButler

![](images/metabutler.jpeg)

[![Codacy Badge](https://app.codacy.com/project/badge/Grade/5af21077123c4a3f9818d860fe66f18a)](https: // www.codacy.com/gh/destroyer19991/MetaButler/dashboard?utm_source=github.com & amp; utm_medium=referral & amp; utm_content=destroyer19991/MetaButler & amp; utm_campaign=Badge_Grade)

MetaButler is an open source Telegram group manager bot, this is a modular based
Telegram Python Bot running on Python3 with sqlalchmey database.

This bot can be found and used on telegram as [MetaButler](https: // t.me/MetaButlerBot).


# Installation

First what you want to do is prepare the configuration file for Metabutler, copy
[sample_config.yml](sample_config.yml) to[config.yml](config.yml) and begin to
fill out all the required information
| Name                     | Required | Description                                                                                                                                         |
|--------------------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------------|
| is_example_config_or_not | Yes      | You need to change the value of this property to `not_sample_anymore` to verify that the configuration file you are running is indeed not a sample. |
| bot_token                | Yes      | Your bot API token that you obtain from BotFather                                                                                                   |
| api_key                  | Yes      | Your Telegram API Key                                                                                                                               |
| api_hash                 | Yes      | Your Telegram API Hash                                                                                                                              |
| owner_username           | Yes      | The username of the owner of this bot (Without the leading @)                                                                                       |
| message_dump             | Yes      | ???                                                                                                                                                 |
| load                     | No       | ???                                                                                                                                                 |
| no_load                  | No       | ???                                                                                                                                                 |
| strict_gban              | No       | ???                                                                                                                                                 |
| workers                  | No       | ???                                                                                                                                                 |
| del_cmds                 | No       | ???                                                                                                                                                 |
| sw_api                   | No       | The API Token for SpamWatch                                                                                                                         |
| database_url             | Yes      | The URL for the Postgres Database, required for the bot to store and retrieve data                                                                  |
| sudo_users               | No       | A list of users that have sudo permissions to this bot (User IDs)                                                                                   |
| whitelist_users          | No       | ???                                                                                                                                                 |

# How can I obtain `bot_token`?

Just talk to[BotFather](https: // t.me/BotFather)(described[here](https: // core.telegram.org/bots  # 6-botfather))
and follow a few simple steps. Once you've created a bot and received your
authorization token, that's it! that's your `bot_token`.

# How can I obtain a `api_key` and `api_hash`?

In order to obtain an API key and hash you need to do the following:

 - Sign up for Telegram using any application.
 - Login to your Telegram core: [https://my.telegram.org](https: // my.telegram.org).
 - Go to '[API Development tools](https://my.telegram.org/apps)' and fill out the form.
 - You will get basic addresses as well as the `api_id` and `api_hash` parameters
   required for Metabutler's configuration file.

# Database

If you wish to use a database-dependent module(eg: locks, notes, userinfo, users, filters, welcomes),
you'll need to have a database installed on your system. I use postgres, so I recommend using it for optimal compatibility.

In the case of postgres, this is how you would set up a the database on a debian/ubuntu system. Other distributions may vary.

- install postgresql:

`sudo apt-get update & & sudo apt-get install postgresql`

- change to the postgres user:

`sudo su - postgres`

- create a new database user(change YOUR_USER appropriately):

`createuser - P - s - e YOUR_USER`

This will be followed by you needing to input your password.

- create a new database table:

`createdb - O YOUR_USER YOUR_DB_NAME`

Change YOUR_USER and YOUR_DB_NAME appropriately.

- finally:

`psql YOUR_DB_NAME - h YOUR_HOST YOUR_USER`

This will allow you to connect to your database via your terminal.
By default, YOUR_HOST should be 0.0.0.0: 5432.

You should now be able to build your database URI. This will be:

`sqldbtype: // username: pw@hostname: port/db_name`

Replace sqldbtype with whichever db youre using(eg postgres, mysql, sqllite, etc)
repeat for your username, password, hostname(localhost?), port(5432?), and db name.

# Requirements

 - PostgreSQL
 - Docker(*optional*)
 - Python3.6 +

# Running Bot
 - pip3 install - r requirements.txt
 - python3 - m metabutler


- ------------------------------------------------------------------------------------

# Thanks to
 - RealAkito - Haruka Aya Owner
 - AnimeKaizoku - SaitamaRobot' owner
 - [SoapDev](https: // github.com/SoapDev2018)
 - And much more that we couldn't list it here!
