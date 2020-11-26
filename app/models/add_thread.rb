class AddThread < ApplicationRecord
    validates :thread_name, {presence: true, uniqueness: true} #同じスレッドを作れないようにしました
    validates :user_name, {presence: true}
    validates :image, {presence: true}
    has_one_attached :image  #activestorageのためのやつ

    def user
        return User.find_by(name: self.user_name)
    end
end
