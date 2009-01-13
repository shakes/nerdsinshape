module TweetsHelper
    def regexit(var)
        retval = LogRegex(var)
        if (retval.blank?)
            retval = InitialTestRegex(var)
        end
        return retval
    end

    protected

    def LogRegex(var)
        regex = Regexp.new('W(eek){0,1}\s*([1-6]).*?D(ay){0,1}\s*([1-3]).*?C(ol|olumn){0,1}\s*([1-3]).*?M(ax){0,1}\s*(\d+)', true)
        matches = regex.match(var)
        if matches
            "Week #{matches[2]}, Day #{matches[4]}, #{matches[8]} max pushups (Column #{matches[6]})"
        else
            ""
        end
    end

    def InitialTestRegex(var)
        regex = Regexp.new('Test.*?(\d+)', true)
        matches = regex.match(var)
        if matches
            "Initial Test with #{matches[1]} pushups"
        else
            ""
        end
    end
end
