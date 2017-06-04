class Article < ApplicationRecord
	belongs_to :user

	def self.search(search)
		where("title || body ILIKE ?", "%#{search}%")
	end
end
