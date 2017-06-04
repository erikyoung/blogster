class Article < ApplicationRecord
	belongs_to :user
	has_many :comments

	validates :title, presence: true
	validates :body, presence: true
	def self.search(search)
		where("title || body ILIKE ?", "%#{search}%")
	end
end
