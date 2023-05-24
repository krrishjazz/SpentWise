class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    JsonWebToken.encode(employee_id: employee.id) if employee
  end

  private

  attr_accessor :email, :password

  def employee
    employee = Employee.find_by_email(email)
    return employee if employee && employee.authenticate(password)

    errors.add :employee_authentication, 'invalid credentials'
    nil
  end
end