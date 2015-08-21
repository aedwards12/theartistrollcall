class ContactFormsController < ApplicationController
  def new
  end

  def create
    contact_form = ContactForm.new(contact_form_params)
    if @contact_form = contact_form.deliver
      flash[:success] = "Email has been successfully sent"
    else
      flash[:notice] = "Email has not successfully sent"
    end
    render 'welcome/contact_form.js'
  end

  private

  def contact_form_params
    params.require(:contact_form).permit(:email, :name, :message)
  end
end
