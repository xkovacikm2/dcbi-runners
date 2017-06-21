class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable

  has_many :runs, dependent: :destroy

  #validations in config/initializers/devise.rb
end
