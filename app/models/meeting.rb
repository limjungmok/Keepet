class Meeting < ActiveRecord::Base
	belongs_to :hospital

	validates :name, presence: true
	validates :start_time, presence: true
	validates :phone, presence: true
	validates :requirement, presence: true

end
