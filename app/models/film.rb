class Film < ActiveRecord::Base
    scope :sorted, lambda { order("films.title ASC")}
    scope :newest, lambda { order("films.year DESC")}
    scope :search, lambda { |query| where(["title LIKE ?", "%#{query}%"])}

	has_many :roles
	has_many :filmmakers, through: :roles
	has_many :extras, as: :include
	has_many :trivia, :through => :extras
	has_many :media, :through => :extras

	accepts_nested_attributes_for :trivia, :allow_destroy => true
	accepts_nested_attributes_for :media, :allow_destroy => false
	accepts_nested_attributes_for :roles, :allow_destroy => false

  validates :title, presence: true
  validates :year, presence: true
  validates :url, presence: true
end