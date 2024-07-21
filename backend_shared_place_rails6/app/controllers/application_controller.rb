class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token
    before_action :setUserDataFromToken, :init_call, :log_ip, 
    def init_call
        Rails.logger.info "PARAMS: #{params.inspect}"

    end

    def log_ip
        # Get the IP address
        ip_address = request.remote_ip
        # Get the port
        port = request.port
        # If you want the complete IP address with the port
        ip_with_port = "#{ip_address}/#{port}"
        Rails.logger.info "IP and port = #{ip_with_port}"
    end

    def setUserDataFromToken
        token = extract_token_from_header
        if token.present?
            params[:userData] = MyJWebToken.decode token
            Rails.logger.debug "\nparams[:userData]= #{params[:userData]}"
        end
    end



    private #==========================>

    def extract_token_from_header
      auth_header = request.headers['Authorization']
      if auth_header.present? && auth_header.starts_with?('Bearer ')
        auth_header.split(' ').last

      else
        # render json: { errors: 'Missing or invalid Authorization header' }, status: :unauthorized
        return nil
      end
    end
end
