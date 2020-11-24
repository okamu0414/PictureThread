class User < ApplicationRecord
    #メアド重複しないように、ユーザの情報にemailは必ず存在するべき
    validates :email, {uniqueness: true, presence: true}
    validates :name, {presence: true}       #ユーザの情報に名前の値は必ず存在するべき
    validates :password, {presence: true}       #ユーザの情報にパスワードも必ず存在するべき
    has_one_attached :image  #activestorageのためのやつ
    
    #ユーザに紐づいた投稿を取得するためにPostインスタンスを戻り値にする
    def posts
        return Post.where(user_id: self.id).order(id: "DESC") #降順=新着順
    end
    
    def to_param
        name
    end
    
end
