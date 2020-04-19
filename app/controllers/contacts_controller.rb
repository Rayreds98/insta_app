class ContactsController < ApplicationController
  before_action :set_contact, only: [:show]

  def index
    @contacts = Contact.all
  end

  def show
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(parmas[contact_params])
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:title, :content)
  end

end
