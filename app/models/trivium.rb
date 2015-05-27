class Trivium < ActiveRecord::Base
	has_and_belongs_to_many :films
	has_and_belongs_to_many :filmmakers
end