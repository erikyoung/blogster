class Article < ApplicationRecord
	belongs_to :user
	has_many :comments, :dependent => :delete_all

	validates :title, presence: true
	validates :body, presence: true
	def self.search(search)
		where("title || body ILIKE ?", "%#{search}%")
	end
end
