class UsersController < ApplicationController

    def get_users
        Rails.logger.debug "get_users"
        Rails.logger.debug "Params: #{params.inspect}"
        users = User.without(:password)
        users = users.map{|u| u.attributes.merge({id:u.id.to_s}).merge({
                                        places: u.places.map{|p| p.attributes}
        })}

        render json:{users: users}.to_json, status:200
    end

    def signup
        unless params[:email].present? && params[:name].present? && params[:password].present?
            error = "Either of email, name, password not sent in the payload"
            render json:{msg: error}.to_json, status:200 and return
        end

        unless params[:password].length >= 6
            msg = "Password length should be 6 or more"
            render json:{msg: error}.to_json, status:200 and return
        end

        user = User.find_by(email:params[:email])
        if user.present?
            error = "The email id is already taken"
            render json:{msg: error}.to_json, status:200 and return
        end

        user = User.new({name: params[:name], email: params[:email], password:params[:password], image:params[:image]})
        if user.save
            h={user_id: user.id.to_s, email:user.email, }
            token = MyJWebToken.encode h
            
            resp = {
            userId: user.id.to_s,
            email: user.email,
            token: token
             }

            # msg = "User #{params[:email]} created sccessfully"
            # resp = {msg: msg}
        else
            error = "Not able to create the user"
            # resp = {error: error}
            render json:{msg: error}.to_json, status:500 and return
        end
        Rails.logger.debug "user = #{user.attributes}"

        render json:resp.to_json, status:200
    end

    def login
        Rails.logger.debug "login #{params[:email]}, #{params[:password]}"
        unless params[:email].present? && params[:password].present?
            error = "The email and/or password not present in the payload"
            resp = {error: error}
            render json:resp.to_json, status:200 and return
        end

        user = User.find_by(email:params[:email])
        if user.nil?
            error = "The user not found"
            resp = {error: error}
            render json:resp.to_json, status:500 and return
        end

        unless user.authenticate(params[:password])
            error = "The password did not match"
            resp = {error: error}
            render json:resp.to_json, status:500 and return
        end

        h={user_id: user.id.to_s, email:user.email, }
        token = MyJWebToken.encode h

        resp = {
            userId: user.id.to_s,
            email: user.email,
            token: token
          }

        render json:resp.to_json, status:200
    end

end
