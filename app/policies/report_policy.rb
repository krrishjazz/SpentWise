class ReportPolicy < ApplicationPolicy
  attr_reader :user, :record

    def initialize(user, report)
      @user = user
      @report = report
    end

    def get_comment
      # @user.admin? || @user.email == @expense.comment.email
      add_comment?
    end

    def add_comment
      @user.admin? || @user.email == @report.email
    end























  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
