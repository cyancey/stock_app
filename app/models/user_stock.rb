class UserStock < ActiveRecord::Base
  belongs_to :user

  validates :ticker_symbol, uniqueness: {scope: :user_id}
  validates :ticker_symbol, presence: true
end
