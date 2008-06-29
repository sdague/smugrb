module Smug
    class Error
        def Error.create(code, msg="")
            case code
                when 5
                return SystemError.new(msg)
                when 6
                return InvalidFormat.new(msg)
                when 9
                return InvalidAlbum.new(msg)
            end
        end
    end
    
    # 5
    class SystemError < Exception
    end

    # 6
    class InvalidFormat < Exception
    end
    
    # 9
    class InvalidAlbum < Exception
    end
    
end
