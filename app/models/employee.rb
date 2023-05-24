class Employee < ApplicationRecord
    has_many :expenses
    has_many :reports

    has_secure_password
end
