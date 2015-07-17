# Slackboard

[![Circle CI](https://circleci.com/gh/takashyx/slackboard/tree/master.svg?style=svg)](https://circleci.com/gh/takashyx/slackboard/tree/master)
[![Code Climate](https://codeclimate.com/github/takashyx/slackboard/badges/gpa.svg)](https://codeclimate.com/github/takashyx/slackboard)
[![Test Coverage](https://codeclimate.com/github/takashyx/slackboard/badges/coverage.svg)](https://codeclimate.com/github/takashyx/slackboard/coverage)
[![Dependency Status](https://gemnasium.com/takashyx/slackboard.svg)](https://gemnasium.com/takashyx/slackboard)

A dashboard rails app to visualise activities in Slack

## Screenshot
![Screenshot](https://raw.github.com/wiki/takashyx/slackboard/images/screenshot.png)

## Dependencies

- rvm
- unicorn
- capistrano3
- chartkick.js

etc

## Slack integration
Set SLACK_TOKEN as an environment value

example:

```bash
export SLACK_TOKEN=xoxp-hogehogehoge......
```

## Crawling

Slackboard is using rake task and whenever to collect slack information.

See config/schedule.rb to check the crawling schedule.

## License
The MIT License (MIT)

See LICENSE file for details.