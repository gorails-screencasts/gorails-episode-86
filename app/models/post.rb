class Post < ActiveRecord::Base
  scope :draft,     ->{ where(published_at: nil) }
  scope :published, ->{ where.not(published_at: nil).where("published_at <= ?", Time.zone.now) }
  scope :scheduled, ->{ where.not(published_at: nil).where("published_at > ?", Time.zone.now)}

  attr_accessor :status

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
