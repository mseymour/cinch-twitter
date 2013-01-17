# Cinch::Twitter

A Cinch plugin for accessing Twitter, using [Erik Michaels-Ober's](https://github.com/sferik/) wonderful [Twitter gem](https://github.com/sferik/twitter).

## Installation

Add this line to your application's Gemfile:

    gem 'cinch-twitter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cinch-twitter

## Usage

### Bot commands

* `!tw <username><+D>` - Gets the latest tweet of the specified user, or the tweet 'D' tweets back, between 1 and 20.
* `!tw #[id]` - Gets the tweet at the specified ID
* `?tw [username]` - Gets the specified user's Twitter profile
* `?ts [term]` - Searches for three of the most recent tweets regarding the specified query

Shorthand commands are also available: 
* `@[username]<+D>`, `@#[id]`

If for instance, an error occurs (such as a timeout, an account is protected, or can't be found), the plugin will send a notice with an informative message.

### Requiring and including the plugin
    require 'cinch/plugins/twitter'
    # ...
    Bot.config {|c|
      # ...
      c.plugins.plugins << Cinch::Plugins::Twitter

### Plugin Configuration

To configure the plugin, you must insert your access keys for the client.

To retrieve your access keys and `oauth` tokens, if you already have an application set up, please visit https://dev.twitter.com/apps, otherwise visit https://dev.twitter.com/apps/new and follow the instructions.

Example:

    c.plugins.options[Cinch::Plugins::Twitter::Client] = { 
      access_keys: { 
        consumer_key: "XXXXXXX", 
        consumer_secret: "XXXXXXX", 
        oauth_token: "XXXXXXX", 
        oauth_token_secret: "XXXXXXX" 
      } 
    }

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
