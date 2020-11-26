class Like < ApplicationRecord
    validates :user_id, {presence: true}
    validates :post_id, {presence: true}

    #ユーザに紐づいた投稿を取得するためにPostインスタンスを戻り値にする
    def posts
        return Post.where(user_id: self.id).order(id: "DESC") #降順=新着順
    end

end
