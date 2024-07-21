require 'bcrypt'
class User
    include Mongoid::Document
    include Mongoid::Timestamps
    include BCrypt

    before_create :encrypt_password
    has_many :places

    field :name, type: String
    field :email, type: String
    field :password, type: String
    field :image, type: String
    # places mongo doc within, has many?

    def encrypt_password
        self.password =  Password.create(self.password)
    end

    # Method to authenticate a user
    def authenticate(unencrypted_password)
        # Rails.logger.debug "\nunencrypted_password  =#{unencrypted_password}"
        Password.new(self.password)== unencrypted_password
    end
    
end