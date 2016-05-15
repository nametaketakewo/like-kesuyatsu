class Task < ActiveRecord::Base
  validates :implement, presence: true, numericality: {only_integer: true, greater_than: 0, less_than_or_equal_to: 3000}
end
