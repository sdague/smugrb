#  smug.rb 
require "open-uri"
require "json"
require "pp"

module Smug
    class Session
        @@base = "https://api.smugmug.com/services/api/json/1.2.1/"
        @key = ""
        @user = ""
        @session = ""
        
        def initialize(apikey, nick)
            @key = apikey
            @user = nick
            login_anon
        end
        
        def login_anon
            # TODO: set header
            # TODO: allow for user
            data = call_json("login.anonymously", :APIKey => @key, :NickName => @user)
            # TODO: catch fail
            @session = data["Login"]["Session"]["id"]
        end
        
        def call_json(m, *args)
            url = "#{@@base}?method=smugmug.#{m}&NickName=#{@user}"
            if args and args[0]
                url += "&" + args[0].collect {|c,v| "#{c}=#{v}"}.join("&")
            end
            puts url
            data = JSON.load(open(url))
            pp data
            return data
        end
        
        def method_missing(m, *args)
            method = m.to_s
            method.gsub!(/_/, ".")
            data = call_json(method, :SessionID => @session, *args)
        end
    end
end
