class PostMailer < ApplicationMailer
    def contact_mail(post)
        @post = post
        mail to: "自分のメールアドレス", subject: "お問い合わせの確認メール"
    end
end
