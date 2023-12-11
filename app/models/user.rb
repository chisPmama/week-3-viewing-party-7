class User < ApplicationRecord 
  validates_presence_of :name,:email, :password_digest
  validates_uniqueness_of :email, uniqueness: true, presence: true

  has_many :viewing_parties
  has_secure_password
end 