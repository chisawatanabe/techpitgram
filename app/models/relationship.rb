class Relationship < ApplicationRecord
belongs_to :user
#Folowクラスという存在しないクラスを参照することを防ぐ
belongs_to :follow, class_name: 'User'

validates :user_id, presence: true
validates :follow_id, presence: true
end
