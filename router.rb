class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
    @running = true
  end

  def run
    while @running
      @employee = @sessions_controller.sign_in
      while @employee
        @employee.rider? ? print_rider_menu : print_manager_menu
        choice = gets.chomp.to_i
        print `clear`
        @employee.rider? ? route_rider_action(choice) : route_manager_action(choice)
      end
    end
  end

  private

  def print_rider_menu
    puts "--------------------"
    puts "---- RIDER MENU ----"
    puts "--------------------"
    puts "1. List my undelivered orders"
    puts "2. Mark my order as delivered"
    puts "7. Logout"
    puts "8. Exit"
    print ">"
  end

  def print_manager_menu
    puts "--------------------"
    puts "----MANAGER MENU----"
    puts "--------------------"
    puts "1. Add new meal"
    puts "2. List all meals"
    puts "3. Add new customer"
    puts "4. List all customers"
    puts "5. Add a new order"
    puts "6. List all undelivered orders"
    puts "7. Logout"
    puts "8. Exit"
    print "> "
  end

  def route_rider_action(choice)
    case choice
    when 1 then @orders_controller.list_my_undelivered_orders(@employee)
    when 2 then @orders_controller.mark_as_delivered(@employee)
    when 7 then logout!
    when 8 then stop!
    else puts "Try again..."
    end
  end

  def route_manager_action(choice)
    case choice
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 5 then @orders_controller.create
    when 6 then @orders_controller.list_undelivered
    when 7 then logout!
    when 8 then stop!
    else puts "Try again..."
    end
  end

  def logout!
    @employee = nil
  end

  def stop!
    logout!
    @running = false
  end
end
