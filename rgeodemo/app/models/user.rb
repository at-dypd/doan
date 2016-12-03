class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role, foreign_key: :role_id

  before_save :add_role

  def add_role
  	self.role_id ||= Role.find_by(name: "admin").id
  end

  def admin?
  	self.role.try(:name) == "admin"
  end
end
