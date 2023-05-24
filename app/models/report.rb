class Report < ApplicationRecord
    belongs_to :employee
    has_many :expenses
    has_many :comments
end
