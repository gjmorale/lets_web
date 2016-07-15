class User < ActiveRecord::Base

  validates :first_name, 	presence: true, length:{maximum:50, minimum:2}
  validates :last_name, 	presence: true, length:{maximum:50, minimum:2}
  validates :social_id, 	presence: true, length:{maximum:14, minimum:10}
  validates :gender, 		presence: true, :inclusion => 0..1
  validates :birth_date, 	presence: true
  validates_format_of :first_name, with: /\A[[A-Za-z]+\ [A-Za-z]+]+\z/i
  validates_format_of :last_name, with: /\A[[A-Za-z]+\ [A-Za-z]+]+\z/i
end
