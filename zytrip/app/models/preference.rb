class Preference < ApplicationRecord

	##############################
	# Preferences Relations
	##############################
	has_one :service
	has_one :company
	has_one :topic
	belongs_to :trip

	##############################
	#Preferences enums
	##############################

	enum destination: {
		spain: 0,
		europe: 1,
		africa: 2,
		america: 3,
		asia: 4
	}, _prefix: true

	enum budget: {
		low: 0,
		medium: 1,
		high: 2,
		expensive: 3
	}, _prefix: true

	enum duration: {
		short: 0,
		ordinary: 1,
		long: 2,
		overlong: 3
	}, _prefix: true


end
