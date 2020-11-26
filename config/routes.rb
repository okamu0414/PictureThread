Rails.application.routes.draw do
  get 'addthreads/add'

  post "likes/:post_id/create" => "likes#create"
  post "likes/:post_id/destroy" => "likes#destroy"

  get "/" => "home#top"
  
  get "login" => "users#login_form"            #ログインページ
  post "login" => "users#login"                 #ログインの機能
  
  #post "users/:id/update" => "users#update"    #編集機能
  # postからpatchに置き換えた
  patch "users/:id/update" => "users#update" 
  get "users/:id/edit" => "users#edit"        #編集ページ
  get "signup" => "users#new"           #新規登録ページ
  post "users/create" => "users#create"    #新規登録ページから受け取ったデータを保存する
  
  get "users/:id" => "users#show"       #ユーザの個人ページ
  # get "users/:name" => "users#show"
  
  post "logout" => "users#logout"               #logoutする、session[:user_id]の中身を消す
  get "users/:id/likes" => "users#likes"    #ユーザがいいねした投稿を表示するやつ
  
  get "thread/index" => "thread#index"
  get "thread/create" => "thread#create"
  post "thread/new" => "thread#new"
  get "thread/:thread_id" => "thread#show"
  get "thread/:thread_id/like_sort" => "thread#like_sort" #いいね順
  
  #スレッドの画像を変更する過程でのアクションルーティングです
  get "thread/:thread_id/image_edit" => "thread#image_edit"
  post "thread/:thread_id/image_changed" => "thread#image_changed"
  
  #スレッドを削除するアクションルーティングです
  post "thread/:thread_id/destroy" => "thread#destroy"
  
  get "posts/:thread_id/create" => "posts#create" #新規投稿のviewに飛ばす
  post "posts/:thread_id/new" => "posts#new" #アクションnewに作成のための値を渡す
  get "posts/:id" => "posts#show" #画像の詳細を表示する際のviewに飛ばす
  post "posts/:id/destroy" => "posts#destroy"
  
  
  #「:thread_name」はアクセスしようとしてるスレッドの名前
  
  #うんち
end
