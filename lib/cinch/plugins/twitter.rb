# coding: utf-8

require "oj"
require "twitter"
require "cgi"
require "time-lord"

module Cinch
  module Plugins
    class Twitter
      include Cinch::Plugin

      set :plugin_name, 'twitter'
      set :help, <<-USAGE.gsub(/^ {6}/, '')
        A Twitter plugin for the bot!
        Usage:
        * !tw <handle(-D)>: Fetch the latest Tweet from the bot or include an offset (I.E. !tw someuser-2) to fetch (-D) Tweets back (up to 19)
        * @<handle(-D): Same as above, just shorthand.
        * !t-search <terms>: Searches recent tweets containing your terms and returns the most recent four. You can search hash tags or do 'to:<handle>' to get the most recent tweets sent to that handle.
        USAGE

      def initialize(*args)
        super
          @client = twitter_client
        end

      match /tw (\w+)(?:-(\d+))?$/, method: :execute_tweet
      match /(\w+)(?:-(\d+))?$/, method: :execute_tweet, prefix: /^@/

      def execute_tweet(m, username, offset)
        offset ||= 0

        user = @client.user(username, include_entities: "1")

        return m.reply "This user's tweets are protected!" if user.protected?
        return m.reply "This user hasn't tweeted yet!" if user.status.nil?

        if offset.to_i > 0
          tweets = @client.user_timeline(user, include_entities: "1")
          return m.reply "You can not backtrack more than #{tweets.count.pred} tweets before the current tweet!" if offset.to_i > tweets.count.pred
          tweet = tweets[offset.to_i]

        else
          tweet = user.status
        end
        m.reply format_tweet(tweet)
      rescue ::Twitter::Error::NotFound => e
        m.reply "#{username} doesn't exist."
      rescue ::Twitter::Error => e
        m.reply "#{e.message.gsub(/user/i, username)}. (#{e.class})"
      end

      match /t-search (.+)/, method: :execute_search

      def execute_search(m, term)    
        @client.search("#{term}", :result_type => "recent").take(4).each do |tweet|
        m.reply format_tweet(tweet)
      end
    end

      match /tw #(\d+)$/, method: :execute_id
      match /#(\d+)$/, method: :execute_id, prefix: /^@/

      def execute_id(m, id)
        tweet = @client.status(id, include_entities: "1")

        m.reply format_tweet(tweet)
      rescue ::Twitter::Error::NotFound => e
        m.reply "#{id} doesn't exist."
      rescue ::Twitter::Error => e
        m.reply "#{e.message.gsub(/user/i, id)}. (#{e.class})"
    end

      private

      def format_tweet(tweet)
        # Username (and retweeted username if applicable)
        head = []
        head << tweet.user.screen_name
        if tweet.retweet?
          head << (tweet.retweeted_status.user.nil? ? "(RT)" : ("(RT from %s)" % tweet.retweeted_status.user.screen_name))
        end

        # Tweet tweet
        body = CGI.unescapeHTML(!!tweet.retweet? ? tweet.retweeted_status.full_text : tweet.full_text).gsub("\n", " ").squeeze(" ")
        body = expand_uris(body, tweet.urls)
        
        # Metadata
        ttime = tweet.created_at.getutc
        tail = []
        tail << ttime.ago.to_time.strftime('%b %-e %Y, %-l:%M %p %Z')
        tail << "from #{tweet.place.full_name}" if !tweet.place.nil? && !!tweet.place.full_name
        tail << "via #{tweet.source.gsub( %r{</?[^>]+?>}, "" )}"

        # URLs for tweet and replied to:
        urls = []
        urls << tweet.url
        urls << "in reply to https://twitter.com/#{tweet.in_reply_to_screen_name}/status/#{tweet.in_reply_to_status_id}" if tweet.reply?

        [Format(:bold, [*head, "»"] * " "), body, ["(", tail * " · ", ")"].join, urls * " "].join(" ")
      end

      def expand_uris(t, uris)
        uris.each_with_object(t) { |entity, tweet| 
          tweet.gsub!(entity.url.to_s, entity.expanded_url.to_s) 
        }
      end

      def twitter_client          
        ::Twitter::REST::Client.new do |c|
          c.consumer_key =        config[:access_keys][:consumer_key]
          c.consumer_secret =     config[:access_keys][:consumer_secret]
          c.access_token =        config[:access_keys][:access_token]
          c.access_token_secret = config[:access_keys][:access_token_secret]
        end
      end
    end
  end
end
