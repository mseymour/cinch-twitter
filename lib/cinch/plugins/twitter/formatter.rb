# coding: utf-8
require 'cgi'
require 'cinch/formatting'

module Cinch
  module Plugins
    class Twitter
      module Formatter

        def format_tweet(tweet)
          tweet_text = expand_uris(tweet.full_text, tweet.urls)
          parts, head, body, tail, urls = [], [], [], [], []
          head = Cinch::Formatting.format(:bold,"#{tweet.user.screen_name} »")
          body << CGI::unescapeHTML(tweet_text.gsub("\n", " ").squeeze(" "))
          body << Cinch::Formatting.format(:aqua,"*twoosh*") if tweet.full_text.length == 140
          tail << "From #{tweet.place.full_name}" if !tweet.place.blank?
          tail << "at #{tweet.created_at.strftime("%B %-d, %Y, %-I:%M%P")}"
          tail << "via #{tweet.source.gsub( %r{</?[^>]+?>}, '' )}"
          urls << "https://twitter.com/#{tweet.user.screen_name}"
          urls << Cinch::Formatting.format(:grey,"in reply to") if !tweet.in_reply_to_screen_name.blank?
          urls << "https://twitter.com/#{tweet.in_reply_to_screen_name}#{"/statuses/#{tweet.in_reply_to_status_id.to_s}" if !tweet.in_reply_to_status_id.blank?}" if !tweet.in_reply_to_screen_name.blank?
          parts = [head, body, ["(", tail.join(" "), ")"].join, urls].flatten
          parts.join(" ")
        end

        def format_search(tweet)
          tweet_text = expand_uris(tweet.full_text, tweet.urls)
          parts, head, body, tail, urls = [], [], [], [], []
          head = Cinch::Formatting.format(:bold,"#{tweet.from_user} »")
          body << CGI::unescapeHTML(tweet_text.gsub("\n", " ").squeeze(" "))
          body << Cinch::Formatting.format(:aqua,"*twoosh*") if tweet.full_text.length == 140
          tail << "at #{tweet.created_at.strftime("%B %-d, %Y, %-I:%M%P")}"
          urls << "https://twitter.com/#{tweet.from_user}"
          parts = [head, body, ["(", tail.join(" "), ")"].join, urls].flatten
          parts.join(" ")
        end

        def format_tweep_info(tweep)
          head =  "#{Cinch::Formatting.format(:aqua,tweep.name)}" + Cinch::Formatting.format(:silver," (#{tweep.screen_name})") + Cinch::Formatting.format(:grey," - #{tweep.url} https://twitter.com/#{tweep.screen_name}")
          bio = ""
          bio = Cinch::Formatting.format(:aqua,"\"#{tweep.description.strip}\"") if !tweep.description.blank?
          location = ""
          location = "They are from #{Cinch::Formatting.format(:aqua,tweep.location.strip)}" if !tweep.location.blank?
          desc = [] << "has made #{tweep.statuses_count} tweets since #{tweep.created_at.strftime("%B %-d, %Y")}"
          desc << "follows #{tweep.friends_count} tweeps" if tweep.friends_count > 0
          desc << "has #{tweep.followers_count} followers" if tweep.followers_count > 0
          desc << "has favourited #{tweep.favourites_count} tweets" if tweep.favourites_count > 0
          desc << "is also in #{tweep.listed_count} lists" if tweep.listed_count > 0
          flags = []
          flags << "is actually a group-run account" if tweep.contributors_enabled?
          flags << "is a translator for Twitter" if tweep.is_translator?
          flags << "is verified" if tweep.verified?
          flags << "would rather keep their life secret" if tweep.protected?
          tweet = [] 
          if tweep.status
            tweep_status_text = expand_uris(tweep.status.full_text, tweep.status.urls)
            tweet << Cinch::Formatting.format(:aqua,"Their latest tweet:")
            tweet << CGI::unescapeHTML(tweep_status_text.gsub("\n", " ").squeeze(" "))
            tweet_tail = []
            tweet_tail << "from #{tweep.status.place.full_name}" if !tweep.status.place.blank?
            tweet_tail << "at #{tweep.status.created_at.strftime("%B %-d, %Y, %-I:%M%P")}"
          end

          parts = [head, bio, location, desc, flags].reject(&:blank?).map {|e| e.is_a?(Array) ? "#{tweep.name} " + e.to_sentence + "." : e }
          parts << [tweet, Cinch::Formatting.format(:silver,["(", tweet_tail.join(" "), ")"].join)].join(" ")
          parts.join("\n")
        end
      
        private
        
        def expand_uris t, uris
          uris.each_with_object(t) {|entity,tweet| tweet.gsub!(entity.url, entity.expanded_url) }
        end

      end
    end
  end
end
