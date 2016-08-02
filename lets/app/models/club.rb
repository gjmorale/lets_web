class Club < ApplicationRecord

	validates :name,	presence: true, length:{maximum: 50, minimum: 3}
	validates :address,	presence: true, length:{maximum: 100, minimum: 10}
	validates :capacity,	presence: true, :inclusion => 50..100000

  	validates_format_of :name, with: /\A[A-Za-z0-9\&\@\#\.\$]+([\!\?]{0,4}(\ |\,\ |\:\ )?[A-Za-z0-9\&\@\#\.\$]+)*[\!\?]{0,4}\z/i
  	validates_format_of :address, with: /\A[A-Za-z0-9]+((\ |\,\ |\:\ |\.\ )?[A-Za-z0-9\#]+)*\z/i
end
