# Slackboard

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