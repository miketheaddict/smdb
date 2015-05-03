class Extra < ActiveRecord::Base
	belongs_to :include, :polymorphic => true
	belongs_to :trivium
	belongs_to :medium
end
