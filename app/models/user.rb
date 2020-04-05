class User < ApplicationRecord

  # この行を追加する
  has_many :posts, dependent: :destroy
  has_many :likes
  has_many :comments
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  #逆方向でフォロワー情報を取得する
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

validates :name, presence: true, length: { maximum: 50 }

def update_without_current_password(params, *options)
  params.delete(:current_password)

  if params[:password].blank? && params[:password_confirmation].blank?
    params.delete(:password)
    params.delete(:password_confirmation)
  end

  result = update_attributes(params, *options)
  clean_up_passwords
  result
end

#follow機能
def follow(other_user)
  unless self == other_user
    self.relationships.find_or_create_by(follow_id: other_user.id)
  end
end

def unfollow(other_user)
  relationship = self.relationships.find_by(follow_id: other_user.id)
  relationship.destroy if relationship
end

def following?(other_user)
  self.followings.include?(other_user)
end

end
