class UsersController < ApplicationController
  def show
    @user = User.find(user_id_in_session)
    @users = User.all
    @movies = @user.viewing_parties.map { |party| MoviesFacade.find_movie(party.movie_id) }
    @user_viewing_parties = UserViewingParty.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path, notice: 'User was successfully created'
    elsif 
      user_params[:password].downcase != user_params[:password_confirmation].downcase
      redirect_to '/register', notice: 'Passwords do not match'
    else
      redirect_to '/register', notice: 'User not created, invalid credentials provided'
    end
  end

  def login_form
  end

  def login
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = "Invalid Credentials"
      redirect_to '/'
    end
  end

  def logout
    session.delete :user_id
    redirect_to '/'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
