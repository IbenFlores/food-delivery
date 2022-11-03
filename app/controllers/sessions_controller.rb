require_relative "../views/sessions_view"

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @sessions_view = SessionsView.new
  end

  def sign_in
    username = @sessions_view.ask_for_stuff("username")
    password = @sessions_view.ask_for_stuff("password")
    employee = @employee_repository.find_by_username(username)
    if employee && employee.password == password
      puts "logged in!"
      employee
    else
      puts "wrong credentials, try again!"
      sign_in
    end
  end
end
