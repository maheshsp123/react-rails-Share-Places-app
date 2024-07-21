class Place
    include Mongoid::Document
    include Mongoid::Timestamps
    
    belongs_to :user, optional: true

    field :title, type: String
    field :description, type: String
    field :image, type: String
    field :address, type: String
    field :location, type: Hash

end