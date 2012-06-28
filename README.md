cinch-twitter
=============

A Cinch plugin for accessing Twitter, using [John Nunemaker's](https://github.com/jnunemaker) wonderful [Twitter gem](https://github.com/jnunemaker/twitter).

Requiring the gem: `require 'cinch/plugins/twitter'`

Usage
-----

* `!tw <username><+D>` - Gets the latest tweet of the specified user, or the tweet 'D' tweets back, between 1 and 20.
* `!tw #[id]` - Gets the tweet at the specified ID
* `?tw [username]` - Gets the specified user's Twitter profile
* `?ts [term]` - Searches for three of the most recent tweets regarding the specified query

Shorthand commands are also available: 
* `@[username]<+D>`, @#[id]

Loading
-------

`c.plugins.plugins << Cinch::Plugins::Twitter::Client`

Configuration
-------------

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

Contributing to cinch-twitter
-----------------------------
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

Copyright
---------

Copyright (c) 2012 Mark Seymour. See LICENSE.txt for
further details.

