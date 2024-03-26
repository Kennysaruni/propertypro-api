class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authorized, only:[:create]
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_user_credentials

    def create
        user = User.create(user_params)
        if user.valid?
            token = encode_token(user_id: user.id)
            render json: {user: UserSerializer.new(user),jwt: token}, status: :created
        else
            render json: {error: user.errors.full_messages},status: :unprocessable_entity
        end
    end

    def create
        user = User.create!(user_params)
        if user
            if (params[:user_type] == 'Owner')
                owner = Owner.create(user_id: user.id, username: user.username, email: user.email)
                token = encode_token({owner_id: owner.id, user_id: user.id})
                render json: {owner: OwnerSerializer.new(owner), jwt: token}, status: :created
            elsif(params[:user_type] == 'Tenant')
                tenant = Tenant.create(user_id: user.id, username:user.username, email: user.email)
                token = encode_token({tenant_id: tenant.id, user_id: user.id})
                render json: {tenant: TenantSerializer.new(tenant),jwt: token}, status: :created
            else
                render json: {error: user.errors.full_messages}, status: :unprocessable_entity
            end
        end
    end

    def show
        user = User.find_by(id: params[:id])
        if user
            render json: {user: user},status: :ok
        else
            render json: {error: user.errors.full_messages}, status: :not_found
        end
    end

    def destroy
        user = User.find_by(id: params[:id])
        if user
            user.destroy
            head :no_content
        else
            render json: {error: 'User not found'}, status: :not_found
        end
    end

    def owner_properties
        owner_id = params[:id]
        properties = Properties.where(owner_id: owner_id)
        render json: properties
    end

    def profile
        if current_user
            render json: {owner: OwnerSerializer.new(owner)}, status: :ok
        elsif
            render json: {tenant: TenantSerializer.new(tenant)}, status: :ok
        end
    end


    private

    def user_params
        params.permit(:username,:email,:password, :user_type)
    end

    def invalid_user_credentials(invalid)
        render json: {error: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
