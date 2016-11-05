class UsersController < ApplicationController
    # Make sure that only assigned user can do certain or specific thing
    before_action :logged_in_user,  only: [:show, :index, :edit, :update, :destroy,
                                           :following, :followers]
    before_action :correct_user,    only: [:edit, :update]
    before_action :admin_user,      only: [:destroy]

    # Action "index" will list all the users in "index.html.erb"
    def index
        @users = User.where(activated: true).paginate(page: params[:page])
    end

    # Action "new" will initialize new user before it will be created in action "create"
    def new
        @user = User.new
    end

    # Action "show" will find id of current user and display it in "show.html.erb" as a profile page
    def show
        @user = User.find(params[:id])
        redirect_to(root_url) && return unless @user.activated?
        @microposts = @user.microposts
        $ads = @user.ads
    end

    # Action "create" create the user and save it in "User" database
    def create
        # Newly created "User" that carrying "user_params" will be saved in "@user"
        @user = User.new(user_params)
        # Method "save" will write the information to database
        if @user.save # When "save" method executed,
            @user.send_activation_email # It will invoke "send_activation_email" method to send email to newly registered user
            flash[:info] = 'Please check your email to activate your account.' # Gives notice to user to check their email,
            redirect_to root_url # and then redirect the user to "root_url" which is the "home.html.erb"
        else
            render 'new' # Render or display the "new.html.erb" which is the "Sign Up" page
        end
    end

    def edit
        # Find the current user id and display it on the form to be updated by action "update"
        @user = User.find(params[:id])
    end

    # Update new information
    def update
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
            flash[:success] = 'Profile updated'
            redirect_to @user
        else
            render 'edit'
        end
    end

    # Delete user
    def destroy
        User.find(params[:id]).destroy
        flash[:success] = 'User deleted'
        redirect_to users_url # Redirect to "index.html.erb" which list all the users
    end

    def following
        @title = 'Following'
        @user = User.find(params[:id])
        @users = @user.following.paginate(page: params[:page])
        render 'show_follow'
    end

    def followers
        @title = 'Followers'
        @user = User.find(params[:id])
        @users = @user.followers.paginate(page: params[:page])
        render 'show_follow'
    end

    private

    # Strong parameter for security to avoid SQL injection
    # The ".permit" method ensure that only parameter specified within are getting to be send to database
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Confirms correct user or registered user
    def correct_user
        @user = User.find(params[:id])
        redirect_to(root_url) unless current_user?(@user)
    end

end
