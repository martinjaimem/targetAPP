class User < ActiveRecord::Base
    validates :email, presence: true, uniqueness: true, length: { minimum: 0, maximum: 2000 }
    validates :first_name, presence: true, uniqueness: false, length: { minimum: 0, maximum: 2000 }
    validates :last_name, presence: true, uniqueness: false, length: { minimum: 0, maximum: 2000 }
    validates :username, presence: true, uniqueness: false, length: { minimum: 0, maximum: 2000 }
    validates :gender, presence: true, uniqueness: false, length: { minimum: 0, maximum: 2000 }
end
