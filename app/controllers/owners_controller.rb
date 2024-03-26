class OwnersController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authorized, only: [:index, :create]

    def index
        user = Owner.all
        render json: user, status: :ok
    end

    def create
        owner = Owner.create(owner_params)
        if owner.save
            render json: {owner: owner}, status: :ok
        else
            render json: {error: 'Owner not found'}, status: :unprocessable_entity
        end
    end
end
