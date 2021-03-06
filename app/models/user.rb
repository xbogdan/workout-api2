class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable #, :rememberable, :validatable

  validates :auth_token, uniqueness: true

  before_create :generate_authentication_token!

  def generate_authentication_token!
    begin
       self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end

  has_many :programs
  has_many :tracks
  has_many :exercises

  has_many :favorite_exercises
  has_many :fav_exercises, through: :favorite_exercises, source: :exercise
end
