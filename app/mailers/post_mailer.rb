class PostMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.post_mailer.post_created.subject
  #
  def post_created
    @greeting = "Hi"
    @user = params[:user]
    @post = params[:post]

    mail(
      from: "support@carsego.com",
      to: User.first.email,
      cc: User.all.pluck(:email),
      bcc: "secret@corsego.com",
      subject: "New post created"
    )

    # to: "krishna.jaiswal@go-yubi.com"
  end
end
