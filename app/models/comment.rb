class Comment < ApplicationRecord
    belongs_to :expense, optional: true
    belongs_to :report, optional: true
end
