Srs::Application.routes.draw do
  get "sessions/new"
  get "password_resets/new"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"

  resources :comments, :posts, :users, :cms, :tabs
  resources :sessions
  resources :password_resets

  match '/' => "pages#home"
  match '/dashboard' => "pages#dashboard"
  match '/about' => "pages#about"
  match '/privacy' => "pages#privacy_policy"
  match '/contact' => "pages#contact"
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  
  # cms routes
  match '/getForeword' => 'cms#foreword'
  match '/getFooter' => 'cms#footer'
  match '/getAboutContent' => 'cms#about'
  match '/getContactContent' => 'cms#contact'
  match '/getPrivacyContent' => 'cms#privacy'
  
  # posts routes
  match '/getRecentPosts' => 'posts#recent_posts'
  match '/getArchivePosts' => 'posts#archive_posts'
  match '/getHomePagePosts' => 'posts#show_home_page_posts'
  match '/view_post' => 'posts#view'
  match '/view_archive' => 'posts#view_archive'

  # comments routes
  match '/getCommentsForm' => 'comments#new'
  match '/getCommentsContent' => 'comments#comments_content'
  match '/getCommentsCount' => 'comments#comments_count'

  # file upload
  match '/upload_file' => 'upload#upload_file'
  match '/upload' => 'upload#upload'
  match '/image_upload' => 'upload#image_upload'
  match '/upload_image' => 'upload#upload_image'

  root :to => "pages#home"
end
