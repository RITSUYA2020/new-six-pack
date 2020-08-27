class ContactsController < ApplicationController
  def new
    # 入力画面を表示
    @contact = Contact.new
  end

  def confirm
    # 入力値のチェック
    @contact = Contact.new(contact_params)
    if @contact.valid?
      render 'confirm'
    else
      render 'new'
    end
  end

  def thanks
    # メール送信
    @contact = Contact.new(contact_params)
    ContactMailer.send_email(@contact).deliver
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
