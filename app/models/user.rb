class User < ActiveRecord::Base
  has_many :harvests, dependent: :destroy
  has_and_belongs_to_many :badges, dependent: :destroy

  # # This method associates the attribute ":avatar" with a file attachment
  # has_attached_file :avatar, styles: {
  #   square: '220x220#'
  # }
  #
  # # Validate the attached image is image/jpg, image/png, etc
  # validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  # Geocoder gem
  geocoded_by :full_address
  after_validation :geocode # if: -> (obj){ obj.address.present? and obj.address_changed? }

  attr_accessor :remember_token, :activation_token
  before_save :downcase_email
  before_create :create_activation_digest
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  validates :street_address, presence: true
  validates :city, presence: true, format: /\A[a-zA-Z]+(?:[\s-][a-zA-Z]+)*\z/
  validates :state, presence: true, format: /[A-Z][A-Z]/
  validates :zipcode, presence: true, format: /\A[0-9]{5}(-[0-9]{4})?\z/

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Activates an account.
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    # UserMailer.account_activation(self).deliver_now
    # UserMailer.welcome_email(self).deliver_now
  end

  # Join user's full address to center map
    def full_address
    [street_address, city, state, zipcode].join(', ')
    end

  # Current user points (based on harvests)
  def points
    totalPoints = 0
    harvests.each do |i|
      if i.animal_type == "bear"
        totalPoints += (i.weight * 4)
      elsif i.animal_type == "moose"
        totalPoints += (i.weight * 0.75).round
      elsif i.animal_type == "turkey"
        totalPoints += (i.weight * 10)
      elsif i.animal_type == "deer"
        totalPoints += (i.weight * 4)
      end
    end
    sprintf '%06d', totalPoints
  end

  # Set badges

  def load_badges
    if self.points.to_i > 0
      award(Badge.find(2)) # harvester: first harvest award
    end
    if true
      award(Badge.find(1)) # gamer: user registered
    end
  end

  def award(badge)
    badges << badge
  end

  def clear_all_badges
    badges.clear
  end

  # Current user level
  def level
    totalLevel = 0
    harvests.each do |i|
      totalLevel += 1
    end
    sprintf '%02d', totalLevel
  end

  private

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end


end
