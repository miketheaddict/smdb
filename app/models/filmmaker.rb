class Filmmaker < Item
	has_many :roles
	has_many :films, through: :roles
end