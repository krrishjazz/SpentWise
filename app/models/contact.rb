class Contact < MailForm::Base
    attribute :name,  :validate => true
    attribute :email,  :validate => true
    attribute :file,  :attachment => true

    attribute :message
    attribute :nickname,  :captcha => true


    def headers
        {
        :subject => "Sending email",
        :to => "krishna.jaiswal@go-yubi.com",
        :from => %("#{name}"<#{email}>)
        }
    end
end