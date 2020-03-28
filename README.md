# ChronoChecker
### Database temporal status made simple

ChronoChecker is a very simple library that uses reflection to query the database temporal status.
Going through your database models (a timestamp field is required), ChronoChecker can help you answer the following questions:

- What's the most recent change?
- What's the oldest change?
- What has changed since a given date?

## Installation

### TODO (not yet on RubyGems)
`gem install chrono_checker`

or in a Gemfile:

`gem 'chrono_checker'`

## Usage

Get the model (database table) with the most recent change:

`ChronoChecker.most_recent_change`

Get the model (database table) with the oldest change:

`ChronoChecker.oldest_change`

Get models (database tables) that have changed since a given date:

`ChronoChecker.changed_as_of(1.day.ago)`