class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :blog_posts

  ROLES = %w[user admin].freeze

  def admin?
    role == 'admin'
  end

  def user?
    role == 'user'
  end
end
