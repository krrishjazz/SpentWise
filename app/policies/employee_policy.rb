class EmployeePolicy < ApplicationPolicy
  attr_reader :user, :record

    def initialize(user, employee)
      @user = user
      @employee = employee
    end
  
    def index?
      # @user.admin?
    end

    def show?
      @user.admin? || @user.email == @employee.email
    end

    def create?
      # false
      @user.admin?
    end

    def new?
      create?
    end

    def update?
      # false
      @user.admin?
    end

    def edit?
      update?
    end

    def destroy?
      # false
      @user.admin?
    end

    def get_expense
      # @user.admin? || @user.email == @employee.email
      add_expense?
    end

    def add_expense
      @user.admin? || @user.email == @employee.expense.email
    end

    def get_report
      # @user.admin? || @user.email == @employee.report.email
      add_report?
    end

    def add_report 
      @user.admin? || @user.email == @employee.report.email
    end









  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end

    
  end
end
