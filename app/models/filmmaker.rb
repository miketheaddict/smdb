class Filmmaker < ActiveRecord::Base
    scope :sorted, lambda { order("filmmakers.lastName ASC")}
    scope :search, lambda { |query| where(["lastName LIKE ? OR firstName LIKE ?", "%#{query}%", "%#{query}%"])}

	has_many :roles
	has_and_belongs_to_many :media
	has_and_belongs_to_many :trivia

	validates :firstName, presence: true
	validates :lastName, presence: true
	validates :birthDate, presence: true
end