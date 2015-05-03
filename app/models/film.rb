class Film < Item
	has_many :roles
	has_many :filmmakers, through: :roles
end