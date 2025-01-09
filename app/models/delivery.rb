class Delivery < ApplicationRecord
  STATES = %w[
    preparation
    sent
    shipping
    delivered
  ].freeze

  def self.find_and_bump_state(book_id)
    delivery = find_by(book_id:)
    if delivery
		  unless delivery.state == STATES[-1]
		    delivery.update(state: STATES[STATES.index(delivery.state) + 1])
		  end

		  delivery
		else
			{}
		end
  end
end
