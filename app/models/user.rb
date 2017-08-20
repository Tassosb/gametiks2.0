class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
  :trackable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:facebook]

  has_and_belongs_to_many :badges
  before_destroy { badges.clear }

  has_many :harvests, dependent: :destroy
  has_many :contacts, through: :contact_follows, source: :contact
  has_many :contact_follows, foreign_key: :user_id, class_name: 'UserContact'
  has_many :conversations, foreign_key: :sender_id
  has_many :comments, dependent: :destroy

  # has_many :contactors, through: :contactor_follows, source: :user
  # has_many :contactor_follows, foreign_key: :user_id, class_name: 'UserContact'

  validates_presence_of :name, :email

  # CarrierWave gem uploader
  mount_uploader :avatar, AvatarUploader

  acts_as_messageable
  def mailboxer_email(object)
    self.email
  end

  def mailboxer_name
    self.name
  end

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

  # Current user points (based on harvests)
  def calc_points
    totalPoints = 0
    harvests.each do |i|
      case i.animal_type
      when 'bear'
        totalPoints += (i.weight * 4)
      when 'moose'
        totalPoints += (i.weight * 0.75).round
      when 'turkey'
        totalPoints += (i.weight * 10)
      when 'deer'
        totalPoints += (i.weight * 4)
      when 'canine'
        totalPoints += 200
      when 'water_fowl'
        totalPoints += 100
      else
        totalPoints += 200
      end
    end
    totalPoints
  end

  def save_points
    self.points = calc_points
    self.save!
  end

  def formatted_points
    sprintf '%06d', points
  end

  def add_contact(user)
    if contacts.include?(user)
      flash[:notice] = 'Member already in your contacts!'
    else
      contacts << user
    end
  end

  def award(badge)
    badges << badge
  end

  def clear_all_badges
    badges.clear
  end

  private

    def downcase_email
      self.email = email.downcase
    end

end
