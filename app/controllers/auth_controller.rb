class AuthController < ApplicationController
    skip_before_action :authorized, only:[:create]
    skip_before_action :verify_authenticity_token

    def create
        user = User.find_by(username: user_login_params[:username])
        if user && user.authenticate(user_login_params[:password])
            token = encode_token({user_id: user.id})
            render json: {user: UserSerializer.new(user), jwt: token} ,status: :accepted
        else
            render json: {error: 'Invalid username or password'}, status: :unauthorized
        end
    end

    private

    def user_login_params
        params.permit(:username, :password)
    end


end
