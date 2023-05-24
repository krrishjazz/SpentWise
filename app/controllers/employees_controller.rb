class EmployeesController < ApplicationController 

    before_action :set_employee, only: %i[  show edit update destroy add_expense get_expense get_report add_report edit_report]
    skip_before_action :verify_authenticity_token 
    
    def index 
        @employees=Employee.all        
        if(params[:query] != nil)
            @employees = @employees.where(name: params[:query])
        end
        render json: @employees        
    end

    def show
        render json:@employee
    end


    def new        
        @employee=Employee.new
    end


    def create        
        @employee=Employee.new(employee_params)
        employee.reimbursement=call_bursement(@employee.employment_status)
            if @employee.save 
                render json: @employee
            else
                render plain:"error in employee addition"
            end
    end
    def call_bursement(status)
        if status == "Terminated"
            return "Not allowed"
        else
            return "Allowed"
        end
    end


    def edit
        render json:@employee    
    end
    def update 
        if @employee.update!(employee_params)
            render json:@employee
        else
            render plain:"error"
        end
    end


    def destroy
        @employee.destroy        
        render plain: "Deleted"
    end


    def get_expense               
        render json:@employee.expenses
    end

    def add_expense
            @expense=@employee.expenses.new                        
            @expense.invoice_number=params[:invoice_number]
            @expense.date=params[:date]
            @expense.description=params[:description]
            @expense.amount=params[:amount]
            @expense.invoice_bill.attach(params[:invoice_bill])
            
            unless @expense.invoice_bill.save                
                render plain: "Bill Not atttached"
                return
            end

            @expense.status=invoice_validator(@expense.invoice_number)            
            if @expense.save          
                #send mail
                render json:@expense
            else
                render plain:"error creating expense"
            end           
    end

    def invoice_validator(invoice_number)
        PostMailer.with(user: User.first, post: Post.first).post_created
        require 'uri'
        require 'net/https'
        require 'json'
        @to_send = { "invoice_id" => invoice_number.to_i }.to_json
        uri = URI.parse("https://my.api.mockaroo.com/invoices.json")
        https = Net::HTTP.new(uri.host,uri.port)
        https.use_ssl = true
        req = Net::HTTP::Post.new(uri.path, initheader = {"X-API-Key" => "b490bb80"})
        req.body = "#{@to_send}"
        res = https.request(req)
        result = JSON.parse(res.body).dig('status')
        if result == true
            SendMailJob.perform_now()            
            # OrderMailer.new_order_email_accept.deliver_now!
            return 'Accepted'
        else
            OrderMailer.new_order_email_reject.deliver_now!
            return 'Rejected'
        end
    end


    def get_report
                
        render json:@employee.reports
    end

    def add_report                      
        @report=@employee.reports.create(report_params)      
        # @report.title=params[:title]        
        # @report.description=params[:description]        
        # @report.amount=0        
        # @report.status=params[:status]   

        if @report.save          
            render json:@report
        else
            render plain:"error creating expense"
        end
    end

    def edit_report
    
        @report=@employee.reports.find(params[:id])
        if @report.update!(report_params)
            render json:@report
        else
            render plain:"error"
        end
    end
    
    private
    def set_employee
        @employee=Employee.find(params[:id])
    end

    def employee_params 
        params.require(:employee).permit(:name,:email,:address,:department, :phone_number,:employment_status,:password_digest)
    end

    def report_params 
        params.permit(:title, :description, :status)
    end   
end