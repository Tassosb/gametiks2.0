class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
  :trackable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:facebook]

  has_many :harvests, dependent: :destroy
  has_and_belongs_to_many :badges, dependent: :destroy

  validates_presence_of :name, :email
  validates_uniqueness_of :email

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.extra.raw_info.email || ''
      user.name = auth.extra.raw_info.name
      user.confirmed_at = Time.now
      user.save!
    end
  end

  def self.new_with_session(params, session)
    if session['devise.user_attributes']
      new(session['devise.user_attributes']) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end


  # attr_accessor :email, :password, :password_confirmation, :remember_me
  # # This method associates the attribute ":avatar" with a file attachment
  # has_attached_file :avatar, styles: {
  #   square: '220x220#'
  # }
  #
  # # Validate the attached image is image/jpg, image/png, etc
  # validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


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
