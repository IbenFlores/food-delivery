require_relative "../models/order"
require_relative "../views/orders_view"
require_relative "../views/meals_view"
require_relative "../views/customers_view"
require_relative "../views/employees_view"
require "pry-byebug"



class OrdersController
  def initialize(order_repo, meal_repo, customer_repo, employee_repo)
    @order_repo = order_repo
    @meal_repo = meal_repo
    @customer_repo = customer_repo
    @employee_repo = employee_repo
    @orders_view = OrdersView.new
    @meals_view = MealsView.new
    @customers_view = CustomersView.new
    @employees_view = EmployeesView.new
  end

  def create
    display_meals
    meal_index = @meals_view.ask_for_stuff("meal index").to_i - 1
    meal = @meal_repo.all[meal_index]
    display_customers
    customer_index = @customers_view.ask_for_stuff("customer index").to_i - 1
    customer = @customer_repo.all[customer_index]
    display_employees
    employee_index = @employees_view.ask_for_stuff("employee index").to_i - 1
    employee = @employee_repo.all_riders[employee_index]
    @order_repo.create(Order.new(meal: meal, customer: customer, employee: employee))
  end

  def list_undelivered
    @orders_view.display(@order_repo.undelivered_orders)
  end

  def list_my_undelivered_orders(employee)
    undelivered_orders = @order_repo.my_undelivered_orders(employee)
    @orders_view.display(undelivered_orders)
  end

  def mark_as_delivered(employee)
    list_my_undelivered_orders(employee)
    order_index = @orders_view.ask_for_stuff("index").to_i - 1
    @order_repo.mark_as_delivered(order_index, employee)
  end

  def display_meals
    meals = @meal_repo.all
    @meals_view.display(meals)
  end

  def display_customers
    customers = @customer_repo.all
    @customers_view.display(customers)
  end

  def display_employees
    employees = @employee_repo.all_riders
    @employees_view.display(employees)
  end
end
