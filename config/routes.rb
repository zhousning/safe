Rails.application.routes.draw do
  root :to => 'controls#index'

  #mount Ckeditor::Engine => '/ckeditor'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  #get 'forget', to: 'admin/dashboard#index'
  #devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  devise_for :users, controllers: { sessions: 'users/sessions' }
  devise_scope :user do
    #get 'forget', to: 'users/passwords#forget'
    #patch 'update_password', to: 'users/passwords#update_password'
    #post '/login_validate', to: 'users/sessions#user_validate'
    #
    #unauthenticated :user do
    #  root to: "devise/sessions#new",as: :unauthenticated_root #设定登录页为系统默认首页
    #end
    #authenticated :user do
    #  root to: "homes#index",as: :authenticated_root #设定系统登录后首页
    #end
  end

  #resources :users, :only => []  do
  #  get :center, :on => :collection
  #  get :alipay_return, :on => :collection
  #  post :alipay_notify, :on => :collection
  #  get :mobile_authc_new, :on => :member
  #  post :mobile_authc_create, :on => :member
  #  get :mobile_authc_status, :on => :member
  #end
  #resources :systems, :only => [] do
  #  get :send_confirm_code, :on => :collection
  #end


  resources :roles

  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :properties
  resources :nests 
  resources :domains 

  #resources :controls, :only => [:index]

  resources :templates do
    get :produce, :on => :member
  end

  resources :wx_templates do
    get :produce, :on => :member
  end

  resources :selectors

  resources :factories, :only => [] do
    resources :devices, :only => [:index]  do
      #post :parse_excel, :on => :collection
      #get :xls_download, :on => :collection
      get :query_all, :on => :collection
    end
    resources :out_reviews do
      get :download_attachment, :on => :member
      get :download_official, :on => :member
      get :download_modified, :on => :member
      get :download_result, :on => :member
      get :download_recheck, :on => :member
      get :query_all, :on => :collection
    end
    resources :inspectors, :only => [:index] do
      get :receive, :on => :member
      get :reject, :on => :member
    end
    resources :workers, :only => [:index, :destroy]  do 
      get :receive, :on => :member
      get :reject, :on => :member
      get :query_info, :on => :member
      get :signlogs, :on => :member
    end
    resources :sign_logs, :only => [:index] do
      get :query_list, :on => :collection
      get :query_device, :on => :collection
    end
    resources :trains do
      get :download_attachment, :on => :member
      get :download_append, :on => :member
      get :query_all, :on => :collection
    end
    resources :drills do
      get :download_attachment, :on => :member
      get :download_append, :on => :member
      get :query_all, :on => :collection
    end
    resources :summaries do
      get :download_attachment, :on => :member
      get :download_append, :on => :member
      get :query_all, :on => :collection
    end
    resources :inventories do
      get :download_append, :on => :member
      get :xls_download, :on => :collection
      get :query_all, :on => :collection
    end
    resources :archives, :except => [:show] do
      resources :portfolios do
        post :upload, :on => :member
      end
    end
    resources :portfolios, :only => [] do
      resources :file_libs do
        get :download, :on => :member
      end
    end
    resources :examines do
      get :export, :on => :member 
      get :report, :on => :member 
      get :drct_org, :on => :member 
      post :create_drct, :on => :member
      resources :documents do
        get :download, :on => :member
      end
    end
    resources :reviews do
      get :download_attachment, :on => :member
      get :download_append, :on => :member
      get :report, :on => :member
      get :reject, :on => :member
      get :complete, :on => :member
      get :query_all, :on => :collection
      resources :review_results do
        get :publish, :on => :member
        get :download_attachment, :on => :member
        get :download_append, :on => :member
        get :download_idappend, :on => :member
        get :query_all, :on => :collection
      end
      resources :modify_results do
        get :download_attachment, :on => :member
        get :download_append, :on => :member
        get :download_idappend, :on => :member
        get :modify, :on => :member
        get :query_all, :on => :collection
      end
      resources :recheck_results do
        get :download_attachment, :on => :member
        get :download_append, :on => :member
        get :download_idappend, :on => :member
        get :recheck, :on => :member
        get :query_all, :on => :collection
      end
    end
  end

  resources :grp_sign_logs, :only => [:index] do
    get :query_list, :on => :collection
    get :query_device, :on => :collection
  end

  resources :grp_inspectors, :only => [:index]

  resources :grp_devices, :only => [:index, :edit, :update, :destroy] do
    collection do
      get 'query_all'
      post 'parse_excel'
      get 'xls_download'
    end
  end

  resources :grp_workers, :only => [:index] do
    get :query_all, :on => :collection
    get :query_info, :on => :member
    get :signlogs, :on => :member
  end

  resources :wx_users, only: [:update] do
    collection do
      post 'get_userid'
      get 'fcts'
      get 'areas'
      get 'streets'
      get 'sites'
      get 'status'
      post 'set_fct'
    end
  end
  resources :wx_tasks, only: [] do
    collection do
      get 'query_all'
      get 'query_finish'
      get 'query_plan'
      get 'basic_card'
      get 'task_info'
      post 'report_create'
    end
  end
  resources :wx_resources, only: [] do
    collection do
      post 'img_upload'
    end
  end
  resources :wx_auths, only: [] do
    collection do
      post 'auth_process'
    end
  end

  resources :grp_trains do
    get :query_device, :on => :collection
    get :query_list, :on => :collection
    get :query_info, :on => :member
  end
  resources :grp_drills do
    get :query_device, :on => :collection
    get :query_list, :on => :collection
    get :query_info, :on => :member
  end
  resources :grp_summaries do
    get :query_device, :on => :collection
    get :query_list, :on => :collection
    get :query_info, :on => :member
  end
  resources :grp_inventories do
    get :query_device, :on => :collection
    get :query_list, :on => :collection
    get :query_info, :on => :member
  end
  resources :grp_examines do
    get :export, :on => :member 
    get :reject_examine, :on => :member 
    get :download_examine, :on => :member 
    get :publish, :on => :member 
    get :drct_org, :on => :member 
    get :drct_info, :on => :member 
    post :create_drct, :on => :member
    resources :documents do
      get :download, :on => :member
    end
  end

  resources :agendas do
    get :download_append, :on => :member
  end

  resources :grp_reviews do
    get :download_attachment, :on => :member
    get :download_append, :on => :member
    get :review, :on => :member
    get :query_all, :on => :collection
    get :publish, :on => :member 
  end
  resources :out_reviews do
    get :download_attachment, :on => :member
    get :download_append, :on => :member
    get :query_all, :on => :collection
  end
  resources :grp_out_reviews do
    get :query_device, :on => :collection
    get :query_list, :on => :collection
    get :query_info, :on => :member
  end
  resources :grp_out_reviews do
    get :query_device, :on => :collection
    get :query_list, :on => :collection
    get :query_info, :on => :member
  end
  resources :flower

end
