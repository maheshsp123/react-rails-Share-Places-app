class PlacesController < ApplicationController

    def getPlacesByUserId
        Rails.logger.debug "Params: #{params.inspect}"
        u  = User.find_by(id:params[:uid])
        if u.nil?
            Rails.logger.debug "no user found"
            render json:{error: "no user found"}, status:200
            return 
        end
        places = u.places.map{|p| p.attributes.merge({id:p.id.to_s, creator:p.user.id.to_s})}
        render json:{places: places.to_ary}, status:200
    end

    def createPlace
        Rails.logger.debug "Params: #{params.inspect}"
        unless params[:title].present? && params[:description].present? && params[:address].present? && params[:creator].present?
            error = "params absent"
            render json:{msg: error}.to_json, status:500 and return
        end

        user = User.find_by(id:params[:creator])
        if user.nil?
            error = "invalid user-creator id"
            render json:{msg: error}.to_json, status:500 and return
        end

        h = {title:params[:title], description:params[:description], address:params[:address]}
        place = Place.new(h)
        place.user = user
        unless place.save
            error = "unable to the place"
            render json:{msg: error}.to_json, status:500 and return
        end
        Rails.logger.debug "place = #{place.attributes}"

        render json:{place: place.attributes}.to_json, status:201

    end

    def getPlaceByPlaceId
        place = Place.find_by(id:params[:pid])
        if place.nil?
            error = "place not found"
            render json:{msg: error}.to_json, status:500 and return
        end

        render json:{place: place.attributes.merge({id:place.id.to_s, creator:place.user.id.to_s})}, status:200
    end

    def updateByPlaceId
        place = Place.find_by(id:params[:pid])
        if place.nil?
            error = "place not found"
            render json:{msg: error}.to_json, status:500 and return
        end

        unless place.user.id.to_s == params[:userData][:user_id]
            error = "place not owned by the user"
            render json:{msg: error}.to_json, status:500 and return
        end
        place.title = params[:title]
        place.description = params[:description]

        unless place.save
            error = "Could not save the place"
            render json:{msg: error}.to_json, status:500 and return
        end

        render json:{place: place.attributes.merge({id:place.id.to_s, creator:place.user.id.to_s})}, status:200

    end


    def deleteByPlaceId
        place = Place.find_by(id:params[:pid])
        if place.nil?
            error = "place not found"
            render json:{msg: error}.to_json, status:500 and return
        end

        unless place.user.id.to_s == params[:userData][:user_id]
            error = "place not owned by the user"
            render json:{msg: error}.to_json, status:500 and return
        end

        unless place.delete
            error = "place could not be deleted"
            render json:{msg: error}.to_json, status:500 and return
        end


        render json:{message: "Deleted place."}.to_json, status:200 and return
    end

end