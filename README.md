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
* add a config file to `config/config.yaml`
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

The MIT License (MIT)

Copyright (c) 2015 Ed Robinson && Jonny Arnold

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

##Built With Love By

[Reevoo Devops](http://reevoo.github.io/) devops@reevoo.com

### Contributions

* [Jonny Arnold](https://github.com/jonnyarnold) - [Only one API call required](https://github.com/reevoo/ci_game/commit/bd3f567aa9013922d32ffde69a02589121b92752)

## Pull Requests
Only if they are awesome/funny

\* yes we really said *gamify* - oh the shame
