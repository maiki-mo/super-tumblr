class User < ActiveRecord::Base
  has_one :profile
  has_many :posts
  has_one :dom
end

class Profile < ActiveRecord::Base
  has_many :posts
  belongs_to :user
end

class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :profile
end