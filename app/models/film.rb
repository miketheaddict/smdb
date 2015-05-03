class Film < ActiveRecord::Base
    scope :sorted, lambda { order("films.title ASC")}
    scope :newest, lambda { order("films.year DESC")}
    scope :search, lambda { |query| where(["title LIKE ?", "%#{query}%"])}

	has_many :roles
	has_many :filmmakers, through: :roles
	has_many :extras, as: :include
	has_many :trivia, :through => :extras
	has_many :media, :through => :extras
end