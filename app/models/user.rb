class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attr_accessible :admin

  def admin?
    admin
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
