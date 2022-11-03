require_relative "../models/employee"

class EmployeeRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @employees = []
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def all_riders
    @employees.select { |employee| employee.rider? }
  end

  def find(id)
    @employees.find { |employee|  employee.id == id}
  end

  def add_employee(employee)
    employee.id = @next_id
  end

  def find_by_username(username)
    @employees.find { |employee| employee.username == username }
  end

  private

  def save_csv
    CSV.open(@csv_file, "wb") do |csv|
      csv << %w[id username password check_in_time role]
      @customers.each do |employee|
        csv << [employee.id, employee.username, employee.password, employee.check_in_time, employee.role]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i
      row[:check_in_time] = row[:check_in_time].to_f
      @employees << Employee.new(row)
    end
    @next_id = @employees.last.id + 1 unless @employees.empty?
  end
end
