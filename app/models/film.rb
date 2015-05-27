class Film < ActiveRecord::Base
    scope :sorted, lambda { order("films.title ASC")}
    scope :newest, lambda { order("films.year DESC")}
    scope :search, lambda { |query| where(["title LIKE ? OR synopsis LIKE ?", "%#{query}%", "%#{query}%"])}

	has_many :roles
	has_and_belongs_to_many :media
	has_and_belongs_to_many :trivia

	validates :title, presence: true
	validates :year, presence: true
	validates :url, presence: true
end