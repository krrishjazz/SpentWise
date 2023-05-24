class ReportsController < ApplicationController 
    skip_before_action :verify_authenticity_token


    def show
        @employee=Employee.find(params[:employee_id])
        @report=@employee.reports.find(params[:id])        
        render json:@report        
    end


    def get_comment
    @report=Report.find(params[:id])
    render json:@report.comments    
    end

    def add_comment
        @employee=Employee.find(params[:employee_id])
        @report=@employee.reports.find(params[:id])
        @comment=@report.comments.new      
        @comment.name=params[:name]
        @comment.comment=params[:comment]

        if @comment.save          
            render json:@comment
        else
            render plain:"error creating expense"
        end
    end

    def get_expense
        @employee=Employee.find(params[:id])
        @report=Report.find(params[:id])       
        render json:@report.expenses
    end

    def add_expense          
            @employee=Employee.find(params[:employee_id])            
            @report=@employee.reports.find(params[:id])
            @expense=@report.expenses.new 
            @expense.invoice_number=params[:invoice_number]
            @expense.date=params[:date]
            @expense.description=params[:description]
            @expense.amount=params[:amount]
            @expense.invoice_bill.attach(params[:invoice_bill])
                        
            puts "============================================"
            unless @expense.invoice_bill.save                
                puts "Bill Not atttached"                
            end          
            @expense.status=invoice_validator(@expense.invoice_number)
            
            puts @report.inspect
            if @expense.save          
                @report.amount += params[:amount].to_i
                @report.save                
                render json:@expense
            else
                puts @expense.errors.full_messages
                render plain:"error creating expense"
            end
    end

    def destroy        
        @employee=Employee.find(params[:employee_id])
            @report=@employee.reports.find(params[:id])
            @expense=@report.expenses.find(params[:id])    
        @expense.destroy        
        render plain: "Deleted"
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
            OrderMailer.new_order_email_accept.deliver_now!
            return 'Accepted'
        else
            OrderMailer.new_order_email_reject.deliver_now!
            return 'Rejected'
        end
    end

    def edit_report
        @employee=Employee.find(params[:employee_id])
        @report=@employee.reports.find(params[:id])

        if @report.update!(report_params)
            if(@report.status == "rejected")
                @report.expenses.each do |expense|
                    expense.status ="rejected"
                    expense.save
                end
            end
            render json:@report
        else
            render plain:"error"
        end
    end

    private
    def report_params 
        params.require(:report).permit(:status)
    end     
end
    
    











