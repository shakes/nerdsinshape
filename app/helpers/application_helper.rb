# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    def twitterify(var)
        var = var.gsub(/@(\w+)/, '@<a href="http://twitter/\1">\1</a>')
        var = var.gsub(/(#Nerds_In_Shape)/,
                       '<a href="http://NerdsInShape.com/">\1</a>')
    end

    def lastupdate
        lastupdate = Status.find_by_id(1)
        if lastupdate
            @lastupdate = lastupdate.updated_at
        else
            @lastupdate = "Not collected yet!"
        end
    end

    def nice_date(date)
        h date.strftime("%a %d %b %Y, %I:%M%p %Z")
    end
end
