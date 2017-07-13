class UserContact < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id', class_name: 'User'
  belongs_to :contact, foreign_key: 'contact_id', class_name: 'User'

  validates_uniqueness_of :user_id, :scope => :contact_id
end
