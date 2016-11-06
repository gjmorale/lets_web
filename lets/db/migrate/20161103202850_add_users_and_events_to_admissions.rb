class AddUsersAndEventsToAdmissions < ActiveRecord::Migration[5.0]
  def change
    add_reference :admissions, :user, foreign_key: true
    add_reference :admissions, :event, foreign_key: true
  end
end
