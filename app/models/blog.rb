class Blog < ApplicationRecord
    validates :title, presence: true
    validates :content, length: { in: 0..200 } 
    validates :content, presence: false
    belongs_to  :user
    has_many :favorites, dependent: :destroy
    has_many :favorite_users, through: :favorites,source: :user
end
