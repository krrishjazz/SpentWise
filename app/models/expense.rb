class Expense < ApplicationRecord
    belongs_to :employee, optional: true
    belongs_to :report, optional: true
    has_many :comments
    has_one_attached :invoice_bill
end
