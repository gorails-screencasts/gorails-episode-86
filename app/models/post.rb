class Post < ActiveRecord::Base
  scope :draft,     ->{ where(status: "Draft") }
  scope :published, ->{ where(status: "Published") }
  scope :scheduled, ->{ where(status: "Scheduled") }

  before_validation :clean_up_status

  def clean_up_status
    self.published_at = case status
                        when "Draft"
                          nil
                        when "Published"
                          Time.zone.now
                        else
                          published_at
                        end
    true
  end
end
