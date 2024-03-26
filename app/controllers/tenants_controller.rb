class TenantsController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authorized

    def index
     render json: Tenant.all
    end

    def create 
        tenant = Tenant.create(tenant_params)
        if tenant.save
            render json: {tenant: tenant}, status: :created
        else
            render json: {error: 'Tenant not created'}, status: :unprocessable_entity
        end
    end

end
