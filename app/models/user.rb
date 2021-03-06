class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_many :exercises, dependent: :destroy
	has_many :workouts, dependent: :destroy
	
	before_save { self.email = email.downcase }

	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence:   true,
					format:     { with: VALID_EMAIL_REGEX },
					uniqueness: { case_sensitive: false }

	#validates :password, length: { minimum: 6 }

	
end
