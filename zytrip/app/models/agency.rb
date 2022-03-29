class Agency < ApplicationRecord
	has_many :trips, dependent: :destroy
end
