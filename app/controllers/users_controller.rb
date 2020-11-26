class UsersController < ApplicationController
  def index
  end
  
  def login_form
    @user = User.new #登録失敗時に戻った際に、入力していた値を表示するため
  end
  
  def login
    @user = User.find_by(
      email: params[:email],
      password: params[:password]
    )                            #emailとpasswordの値が同じなユーザを@userに代入
    if @user                                #ユーザが存在する場合の処理
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/users/#{@user.id}")
    else                                     #ユーザが存在しない場合の処理
      @error_message ="メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end
  
  def new
    @user = User.new #登録失敗時に戻った際に、入力していた値を表示するため
  end
  
  def show
    @user = User.find_by(id: params[:id])
    #@user = User.find_by(name: params[:name])
  end
  
  def edit
    @user = User.find_by(id: params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    # @user.name = params[:name]
    # @user.email = params[:email]
    #patch処理にしたり、railsのアップデートで置き換えた
    @user.update(user_params)
    # @user.image.attach(params[:name])
    # @user.image.attach(params[:email])
    # @user.image.attach(params[:image])
    
    # if params[:image]
    #   @user.image_name = "#{@user.id}.png"
    #   image = params[:image]
    #   File.binwrite("public/user_images/#{@user.image_name}", image.read)
    # end
      
    if @user.save
      flash[:notice] = "ユーザ情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end
  
  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      image: nil
    )    #新しいインスタンスを作成
    if @user.save    #それをデータベースに保存
      session[:user_id] = @user.id
      flash[:notice] = "新規登録ができました"
      redirect_to("/thread/index")   #新規登録後スレッド一覧に移動
    else
      render("users/new")
    end
  end
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end
  
  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id).order(id: "DESC") #降順=新着順

    #いいねした投稿を@postsにまとめている
    @likes.each do |like|
      @posts = Post.where(id: like.post_id)
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :image)
    end

end
