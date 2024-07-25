class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :people, dependent: :destroy
  has_many :interactions, :through :people

  validates :first_name, presence: true
  validates :last_name, presence: true
end
