module TweetsHelper
    def regexit(var)
        regex = Regexp.new('W(eek){0,1}\s*([1-6]).*?D(ay){0,1}\s*([1-3]).*?C(ol|olumn){0,1}\s*([1-3]).*?M(ax){0,1}\s*(\d+)')
        matches = regex.match(var)
        if matches
            "Week #{matches[2]}, Day #{matches[4]}, #{matches[8]} max pushups (Column #{matches[6]})"
        else
            return ""
        end
    end
end
