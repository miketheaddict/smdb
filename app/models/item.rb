class Item < ActiveRecord::Base
	has_and_belongs_to_many :trivia
	has_and_belongs_to_many :media
end