class OrdersView
  def display(orders)
    orders.each_with_index do |order, index|
      delivered = order.delivered? ? "[X]" : "[ ]"
      puts "#{index + 1} #{delivered} - meal: #{order.meal.name}, customer: #{order.customer.name}, rider: #{order.employee.username}"
    end
  end

  def ask_for_stuff(stuff)
    puts "what's the #{stuff}?"
    print ">"
    gets.chomp
  end
end
