class Exercise < ActiveRecord::Base
	has_many :weight_logs, dependent: :destroy
	
	belongs_to :user

	has_many :workout_exercises
	has_many :workouts, :through => :workout_exercises
	
	validates :name, presence: true, length: { maximum: 100 }
	validates_uniqueness_of :name, :scope => :user_id, :case_sensitive => false
	default_scope -> { order('name ASC') }
	
end
