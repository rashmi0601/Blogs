class BlogPost < ApplicationRecord
  belongs_to :user
  
  has_many_attached :files

  enum status: { pending: 'pending', approved: 'approved', rejected: 'rejected' }, _default: 'pending'
  validates :title , presence: true
  validates :content, presence: true
end
