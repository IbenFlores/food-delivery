class Employee
  attr_accessor :id
  attr_reader :username, :password, :check_in_time

  def initialize(attr = {})
    @id = attr[:id]
    @username = attr[:username]
    @password = attr[:password]
    @check_in_time = attr[:check_in_time]
    @role = attr[:role]
  end

  def authorization(password)
    if password == @password
      puts "you're logged in, check in time: #{@check_in_time}"
    else
      puts "wrong password, try again"
    end
  end

  def rider?
    @role == "rider"
  end

  def manager?
    @role == "manager"
  end
end
