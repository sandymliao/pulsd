class NewEvent < ActiveRecord::Base
  validates :count, presence: true
end
