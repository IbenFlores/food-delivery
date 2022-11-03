class EmployeesView
  def display(employees)
    employees.each_with_index do |employee, index|
      puts "#{index + 1} - #{employee.username}"
    end
  end

  def ask_for_stuff(stuff)
    puts "what's the #{stuff}"
    print ">"
    gets.chomp
  end
end
