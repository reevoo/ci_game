# CI Game

[![Build Status](https://travis-ci.org/reevoo/ci_game.svg?branch=master)](https://travis-ci.org/reevoo/ci_game)
[![Code Climate](https://codeclimate.com/github/reevoo/ci_game/badges/gpa.svg)](https://codeclimate.com/github/reevoo/ci_game)
[![Test Coverage](https://codeclimate.com/github/reevoo/ci_game/badges/coverage.svg)](https://codeclimate.com/github/reevoo/ci_game)

## WTF

Wants to Gameify your CI? Who doesn't?

Take your most flaky test suite and gamify\* it with the latest in ASCII based email encouragement.

## Tell Me How it Works . . . NOW!

* clone this repo `git@github.com:reevoo/ci_game.git`
* `bundle install`
* add a config file to `config\config.yaml`
````yaml
jenkins_host: 'http://ci-goodness.awesome'
games:
  - flakey_test_sute
  - our_awesome_new_app
email_adresses:
  - your.boss@megacorp.com
  - anyone@youlike.com
  - please.dont@spam.me
````
* run it somewhat often `bin/ci_game` with cron or a while loop or somesuch.

##Licence
You are kidding right...
... you may use this all you like, so long as we don't catch you doing it.

##Authored By
Reevoo Devops devops@reevoo.com

## Pull Requests
Only if they are awesome/funny

\* yes we really said *gamify* - oh the shame
