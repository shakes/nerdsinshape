require 'date'

class Status < ActiveRecord::Base

    def self.Update
        x = find_or_create_by_id(1)
        x.updated_at = DateTime.now
        x.save!
    end
end
