# Version 1.0.2
  * Fixes an issue where retweeted statuses' have no user associated with them

# Version 1.0.1
  * Unescapes HTML in tweets
  * Expands t.co links to full URIs as has been in previous versions prior to 1.0.0

# Version 1.0.0
  * Major rewrite from the ground up
  * Uses Twitter gem 4.8 (API v.1.1)
  * Removes ?ts and ?tw commands (twitter search and twitter user info respectively)
  * Your OAuth and access keys can still be entered the same way as before in config

# Version 0.3.12 + 0.3.13
  * Various fixes
  * Fixing Gemfile's dependencies

# Version 0.3.8 .. Version 0.3.11
  * ?tw <nick> no longer raises an exception when status does not exist.

# Version 0.3.7
  * Another minor fix. Made https the standard for all links.

# Version 0.3.6
  * Query commands (?tw, ?ts) now only fire if the command is at the start of the line.

# Version 0.3.4 + 0.3.5
  * Removed useless addition of the bots nick for ENHANCE_YOUR_CALM and reworded message.
  * Removed formatting for error messages since Cinch's Format() cannot seem to be accessible in the ErrorHandler module.

# Version 0.3.3
  * Various updates and fixes

# Version 0.3.0
  * The plugin now requires Twitter 3.0.0 and above.

# Version 0.2.0
  * The plugin can now be included via `Cinch::Plugins::Twitter`.

# Version 0.1.0
  * Initial release
