class AddReporttoComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :report, null: true, foreign_key: true
  end
end
