class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :index]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy
  before_filter :signed_in_user_for_new, only: [:new, :create]

	def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
  		# Handle a successful save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
  	else
    	render 'new'
  	end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      #Handle a successful update
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    u = User.find(params[:id])
    if u.admin?
      flash[:error] = "Cannot destroy an admin user."
      redirect_to(root_path)
    else
      u.destroy
      flash[:success] = "User destroyed."
      redirect_to users_url
    end
  end




  private
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def signed_in_user_for_new
      redirect_to(root_path) unless not signed_in?
    end
end
