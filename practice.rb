# create a new Class, User, that has the following attributes:
# - name
# - email
# - password
class User
    def initialize(name, email, password) 
      @name = name  
      @email = email  
      @password = password 
      @rooms = []  
    end
  
    # add a method to user so, user can enter to a room
    # user.enter_room(room)
    def enter_room(room)
      @rooms << room  
      room.users << self  
    end
  
    # add a method to user so, user can send a message to a room
    # user.send_message(room, content)
    def send_message(room, content)
      message = Message.new(self, room, content)  
      room.broadcast(message)  
    end
  
    # user.ackowledge_message(room, message)
    def acknowledge_message(room, message)
      @acknowledged_messages ||= {}  
      room_messages = @acknowledged_messages[room] ||= {} 
      room_messages[message] = true 
    end
end
  
  # create a new Class, Room, that has the following attributes:
  # - name
  # - description
  # - users
class Room
    attr_accessor :users  
    
    def initialize(name, description, users = [])
      @name = name  
      @description = description  
      @users = users   # Initialize users correctly
      @messages = []  
    end
  
    # add a method to a room, so it can broadcast a message to all users
    # room.broadcast(message)
    def broadcast(message)
      @messages << message  
      @users.each { |user| user.acknowledge_message(self, message) }  
    end
end
  
  # create a new Class, Message, that has the following attributes:
  # - user
  # - room
  # - content
class Message
    def initialize(user, room, content)
      @user = user  
      @room = room  
      @content = content  
    end
end
  
# Create an instance of User
user1 = User.new("Thakdanai", "thakdanai@example.com", "mypassword")
  
# Create an instance of Room
room1 = Room.new("General", "This is a general chat room.")
user1.enter_room(room1)
  

user1.send_message(room1, "Hello, everyone! I'm Thakdanai.")
  
puts "User #{user1.instance_variable_get(:@name)} has entered the room #{room1.instance_variable_get(:@name)}."
puts "Message sent: 'Hello, everyone! I'm Thakdanai.'"
  