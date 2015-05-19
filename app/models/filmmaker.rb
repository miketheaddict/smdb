class Filmmaker < ActiveRecord::Base
    scope :sorted, lambda { order("filmmakers.lastName ASC")}
    scope :search, lambda { |query| where(["lastName LIKE ? OR firstName LIKE ?", "%#{query}%", "%#{query}%"])}

	has_many :roles
	has_many :films, through: :roles
	has_many :extras, as: :include
	has_many :trivia, :through => :extras
	has_many :media, :through => :extras
end