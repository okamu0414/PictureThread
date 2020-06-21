class Post < ApplicationRecord
    validates :image_name, {presence: true}  #からの投稿を防ぐ
    validates :user_id, {presence: true}  #だれが投稿したかの情報は必ず必要
    #validates :thread_name, {presence: true}     #必ずどこかのスレッドには属している必要がある
    #↑一旦解決策見つかるまでコメントアウトします
    
    #投稿に紐づいたuserインスタンスを返すメソッド
    def user
        return User.find_by(id: self.user_id)
    end
    
    def post_thread_name
        return AddThread.find_by(thread_name: self.thread_name)
    end
end
