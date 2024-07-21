h={user_id: "123qweQW3243", email:"ahsg@jk.kl"}
token = MyJWebToken.encode h
puts "token: #{token}"
hd = MyJWebToken.decode token
puts "decoded = #{hd}"
###########################################################################
# require 'bcrypt'
# class Test1
#   include BCrypt

#   def run1
#     password_digest = Password.create("new_password")
#     puts password_digest
#     puts Password.new(password_digest) == "new_password1"
#   end
# end

# Test1.new().run1

# h = {name:"user4", email:"user4@dom.com", password:"user4",image:"image_link"}
# u = User.new(h)
# u.save
# puts u.attributes

# ---------------------------------
# {
#     id: 'p1',
#     title: 'Empire State Building',
#     description: 'One of the most famous sky scrapers in the world!',
#     imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/df/NYC_Empire_State_Building.jpg/640px-NYC_Empire_State_Building.jpg',
#     address: '20 W 34th St, New York, NY 10001',
#     location: {
#       lat: 40.7484405,
#       lng: -73.9878584
#     },
#     creator: 'u1'
#   }

# {
#     id: 'p2',
#     title: 'Empire State Building',
#     description: 'One of the most famous sky scrapers in the world!',
#     imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/df/NYC_Empire_State_Building.jpg/640px-NYC_Empire_State_Building.jpg',
#     address: '20 W 34th St, New York, NY 10001',
#     location: {
#       lat: 40.7484405,
#       lng: -73.9878584
#     },
#     creator: 'u2'
#   }

####################################################################
# h = {title:"4 Empire State Building", description:"4 One of the most famous sky scrapers in the world!", image:"https://upload.wikimedia.org/wikipedia/commons/thumb/d/df/NYC_Empire_State_Building.jpg/640px-NYC_Empire_State_Building.jpg", address: "20 W 34th St, New York, NY 10001", location: {
#           lat: 40.7484405,
#           lng: -73.9878584
#         }}
# u = User.find_by(id:"666c5f27b92bae8016966a34")
# p1 = Place.new(h)
# p1.user = u
# unless p1.save
#     puts "save error}"
#     puts p1.errors.full_messages
# end
# # ?puts "save = #{p.save}"
# puts p1.attributes