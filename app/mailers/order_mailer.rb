class OrderMailer < ApplicationMailer
    def new_order_email_accept
        mail(to: "krishna.jaiswal@go-yubi.com", subject: "Your expense is Accepted")
    end
    def new_order_email_reject
        mail(to: "krishna.jaiswal@go-yubi.com", subject: "Your expense is Rejected")
    end
end
