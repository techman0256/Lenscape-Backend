class ApplicationController < ActionController::API
    before_action :permit_all_parameters

    private
    def permit_all_parameters
        params.permit!
    end
end
