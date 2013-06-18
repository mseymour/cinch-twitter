# coding: utf-8

require "oj"
require "twitter"

module Cinch
  module Plugins
    class Twitter
      include Cinch::Plugin
      
      TWITTER_URL_BASE = 'https://twitter.com/'
      
      set(
        plugin_name: "Twitter",
        help: "Access Twitter from the comfort of your IRC client! Usage:\n* `!tw <username><+D>` - Gets the latest tweet of the specified user, or the tweet 'D' tweets back, between 1 and 20.\n* `!tw #[id]` - Gets the tweet at the specified ID\n* `?tw [username]` - Gets the specified user's Twitter profile\n* `?ts [term]` - Searches for three of the most recent tweets regarding the specified query\n\nShorthand: `@[username]<+D>`, @#[id]",
        required_options: [:access_keys])
      
      def initialize *args
        super
        ::Twitter.configure do |c|
          c.consumer_key = config[:access_keys][:consumer_key]
          c.consumer_secret = config[:access_keys][:consumer_secret]
          c.oauth_token = config[:access_keys][:oauth_token]
          c.oauth_token_secret = config[:access_keys][:oauth_token_secret]
        end
      end
      
      match /tw (\w+)(?:-(\d+))?$/, method: :execute_tweet
      match /(\w+)(?:-(\d+))?$/, method: :execute_tweet, prefix: /^@/
      def execute_tweet m, username, offset
        offset ||= 0
        tweets = ::Twitter.user_timeline(username)
        tweet = tweets[offset.to_i]
        m.reply format_tweet(tweet)
      end
      
      private
      
      def format_tweet tweet
        # Username (and retweeted username if applicable)
        head = []
        head << tweet.user.screen_name
        head << "(RT from %s)" % tweet.retweeted_status.user.screen_name if tweet.retweet?
        
        # Tweet tweet
        body = !!tweet.retweet? ? tweet.retweeted_status.full_text : tweet.full_text
        
        # Metadata
        tail = []
        tail << tweet.created_at.strftime("at %b %-d %Y, %-l:%M %p %Z")
        tail << "from #{tweet.place.full_name}" if !!tweet.place
        tail << "via #{tweet.source.gsub( %r{</?[^>]+?>}, '' )}"
        
        # URLs for tweet and replied to:
        urls = []
        urls << "#{TWITTER_URL_BASE}#{tweet.user.screen_name}/status/#{tweet.id}"
        urls << "in reply to #{format_reply_url(tweet.in_reply_to_screen_name, tweet.in_reply_to_status_id)}" if tweet.reply?
        
        [Format(:bold, [*head, '»'] * ' '), body, ['(', tail * ' · ', ')'].join, urls * ' '].join(' ')
      end
      
      def format_reply_url(username, id)
        "#{TWITTER_URL_BASE}#{username}#{"/status/#{id}" if !!id}"
      end
      
    end
  end
end
