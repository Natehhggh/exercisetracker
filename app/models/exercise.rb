class Exercise < ActiveRecord::Base
	has_many :weight_logs
	
	validates :name, presence: true, length: { maximum: 100 }, uniqueness: { case_sensitive: false }
end
