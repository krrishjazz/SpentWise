class ExpensesController < ApplicationController     
    skip_before_action :verify_authenticity_token 

    def show
        @employee=Employee.find(params[:employee_id])
        @report=@employee.reports.find(params[:report_id])
        @expense=@report.expenses.find(params[:id])
        render json:@expense
    end

    def update
        @employee=Employee.find(params[:employee_id])
        @report=@employee.reports.find(params[:report_id])
        @expense=@report.expenses.find(params[:id])
        if @expense.update!(expense_params)
            render json:@expense
        else
            render plain:"error"
        end
    end

    def destroy
        @employee=Employee.find(params[:employee_id])
            @report=@employee.reports.find(params[:report_id])
            @expense=@report.expenses.find(params[:id])    
        @expense.destroy        
        render plain: "Deleted"
    end

    def get_comment
        @expense=Expense.find(params[:id])
        render json:@expense.comments
    end

    def add_comment
        @employee=Employee.find(params[:employee_id])
        @expense=@employee.expenses.find(params[:id])
        @comment=@expense.comments.new        
        @comment.name=params[:name]
        @comment.comment=params[:comment]
                
        if @comment.save          
            render json:@comment
        else
            render plain:"error creating expense"
        end    
    end

private
    def expense_params 
        params.require(:expense).permit(:status)
    end 
end