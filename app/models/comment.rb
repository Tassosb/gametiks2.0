class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :harvest

  before_save :ensure_body_not_blank

  private

  def ensure_body_not_blank
    body.gsub(/\s+/, "") != ""
  end
  
end
