#  smug.rb 
require "open-uri"
require "json"
require "pp"

module Smug
    class Session
        @@base = "https://api.smugmug.com/services/api/json/1.2.1/"
        @key = ""
        @user = ""
        @passwd = ""
        @session = ""
        
        def initialize(apikey, nick, passwd="")
            @key = apikey
            @user = nick
            @passwd = passwd
            if not passwd
                login_anon
            else
                login_auth(nick)
            end
            
        end
        
        def login_anon
            # TODO: set header
            # TODO: allow for user
            data = call_json("login.anonymously", :APIKey => @key, :NickName => @user)
            # TODO: catch fail
            @session = data["Login"]["Session"]["id"]
        end

        def login_auth(user)
            # TODO: set header
            # TODO: allow for user
            data = call_json("login.withPassword", :APIKey => @key, :EmailAddress => user, :Password => @passwd)
            
            # TODO: catch fail
            @session = data["Login"]["Session"]["id"]
            @user = data["Login"]["User"]["NickName"]
        end

        def call_json(m, *args)
            pp args
            url = "#{@@base}?method=smugmug.#{m}"
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
            if args
                if args[0]
                    args[0]["Session"] = @session
                else
                    args = [{ :Session => @session }]
                end
            else
                args = [{ :Session => @session }]
            end
            data = call_json(method, *args)
        end
    end
end
