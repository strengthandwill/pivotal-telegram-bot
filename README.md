# Pivotal Telegram Bot

This telegram bot will integrate with your Pivotal Tracker projects.

The following events are tracked:
* Create a new story
* Change a story
* Change a status of story
* Delete a story
* Complete a task of the story
* Uncomplete a task of the story
* Add a new comment to the story
* Edit a comment to the story
* Create a new epic

This events can be change at: 

```sh
app/helpers/activity_helper.rb#get_message
```

## Installation
(1) Run the following to generate the application.yml
```sh
$ bundle exec figaro install
```

(2) Update the application.yml with your environment variables:
```sh
telegram_token:     [your_telegram_token]
telegram_chat_id:   [your_telegram_chat_id]
```

(3) Add Activity Web Hook to Pivotal Tracker project
* Goto [your_project] > Settings > Configure Integrations > Activity Web Hock
* Add 'https://[your_host]/api/v1/activity' to URL 

## Contact Me
* Email me @ <kahkongmail@hotmail.com>
* Personal site @ <a href="http://www.pohkahkong.com" target="_blank">www.pohkahkong.com</a>
* Web/App Studio @ <a href="http://www.algomized.com" target="_blank">www.algomized.com</a>