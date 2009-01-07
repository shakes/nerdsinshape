# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    def twitterify(var)
        var.gsub(/@(\w+)/, '@<a href="http://twitter/\1">\1</a>')
    end

    def lastupdate
        lastupdate = Status.find_by_id(1)
        if lastupdate
            @lastupdate = lastupdate.updated_at
        else
            @lastupdate = "Not collected yet!"
        end
    end
end
