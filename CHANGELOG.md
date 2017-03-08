# Version 2.0.6
  * Updates dependencies to the latest version of Cinch and Twitter gems.
  * Code cleanup

# Version 2.0.5
  * Fixes a regression where a removed method made any tweets that had replies cause an exception to be raised.

# Version 2.0.3
  * Fixes many regressions introduced in 2.0.2, including URLs not being expanded and parts of the tweet metadata being blank (i.e. 'from XXX')
  * Switches back to UTC time for all tweet output
  * Various small fixes

# Version 2.0.2
  * Brings everything up to the latest version of the Twitter gem. Portions rewritten by @Namasteh.

# Version 1.0.4
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
