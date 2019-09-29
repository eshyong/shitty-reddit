class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      create_new_session
      redirect_to(posts_index_path)
    else
      render 'new'
    end
  end

  def login
    @user = User.new
  end

  def logout
    destroy_session
    redirect_to(posts_index_path)
  end

  def authenticate
    @user = User.find_by(name: user_params[:name])
    if @user.nil?
      flash[:notice] = 'No user found with that name, try creating a new user'
      render 'user' and return
    end

    @user = @user.try(:authenticate, user_params[:password])
    if @user
      create_new_session
      redirect_to(session[:redirect_to_path])
    else
      flash[:notice] = 'Invalid password; please try again'
      render 'user'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

  def create_new_session
    session.update(user_id: @user.id, username: @user.name, logged_in: true)
  end

  def destroy_session
    session.update(user_id: nil, username: nil, logged_in: false)
  end
end
