class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
  :trackable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:facebook]

  has_and_belongs_to_many :badges
  before_destroy { badges.clear }

  has_many :harvests, dependent: :destroy
  has_many :credits, dependent: :destroy
  has_many :credited_harvests, through: :credits, source: :harvest
  has_many :contacts, through: :contact_follows, source: :contact
  has_many :contact_follows, foreign_key: :user_id, class_name: 'UserContact'
  has_many :conversations, foreign_key: :sender_id
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

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
        totalPoints += (i.weight * 0.9).round
      when 'turkey'
        totalPoints += (i.weight * 10)
      when 'deer'
        totalPoints += (i.weight * 3.8)
      when 'bovid'
        totalPoints += (i.weight * 4.2)
      when 'canine'
        totalPoints += 250
      when 'water_fowl'
        totalPoints += 250
      else
        totalPoints += 250
      end
    end
    totalPoints
  end

  def has_earned?(badge)
    case badge.title
      when 'Deer Hunter'
        self.harvests.any? { |harvest| harvest.animal_type == 'deer' }
      when 'Bear Hunter'
        self.harvests.any? { |harvest| harvest.animal_type == 'bear' }
      when 'Turkey Hunter'
        self.harvests.any? { |harvest| harvest.animal_type == 'turkey' }
      when 'Moose Hunter'
        self.harvests.any? { |harvest| harvest.animal_type == 'moose' }
      when 'Duck Hunter'
        self.harvests.any? { |harvest| harvest.animal_type == 'water_fowl' }
      when 'Canine Hunter'
        self.harvests.any? { |harvest| harvest.animal_type == 'canine' }
      when 'Bovid Hunter'
        self.harvests.any? { |harvest| harvest.animal_type == 'bovid' }
      when 'Archer'
        self.harvests.select { |harvest| harvest.weapon_type == 'bow' }.length >= 3
      when 'Gunslinger'
        self.harvests.select { |harvest| harvest.weapon_type == 'pistol' }.length >= 3
      when 'Shotgunner'
        self.harvests.select { |harvest| harvest.weapon_type == 'shotgun' }.length >= 3
      when 'Rifleman'
        self.harvests.select { |harvest| harvest.weapon_type == 'rifle' }.length >= 3
      when 'Staff Pick'
        true
      else
        false
    end
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
