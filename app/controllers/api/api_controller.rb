module Api
    class ApiController < ApplicationController
        # include DeviseTokenAuth::Concerns::SetUserByToken
        # skip_before_filter :verify_authenticity_token
        # skip_before_action :authenticate_user!, raise: false
        protect_from_forgery with: :null_session
        protect_from_forgery prepend: true
        # before_filter :authenticate_api_user!
        
        # devise_token_auth_group :member, contains: [:user]
        # before_action :authenticate_member!
        
        # def members_only
        #     render json: {
        #         data: {
        #             message: "Welcome #{current_member.name}",
        #             user: current_member
        #         }
        #     }, status: 200
        # end
    end
end