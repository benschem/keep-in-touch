class Api::V1::ContactsController < ApplicationController
  before_action :set_person, only: %i[index show create update destroy]
  before_action :set_contact, only: %i[show update destroy]

  # GET /people/1/contacts
  def index
    @contacts = @person.contacts
    render_success("Contact history for #{@person.name} fetched successfully", @contacts)
  end

  # GET /people/1/contacts/1
  def show
    render_success("Contact details fetched successfully", @contact)
  end

  # POST /people/1/contacts
  def create
    @contact = @person.contacts.new(contact_params)
    if @contact.save
      render_created("New contact history created successfully", @contact)
    else
      render_error("New contact history cannot be created", @contact.errors)
    end
  end

  # PATCH/PUT /people/1/contacts/1
  def update
    if @contact.update(contact_params)
      render_success("Contact history updated successfully", @contact)
    else
      render_error("Contact history cannot be updated", @contact.errors)
    end
  end

  # DELETE /people/1
  def destroy
    if @contact.destroy
      render_success("Contact history deleted successfully", nil)
    else
      render_error("Contact history cannot be deleted", @contact.errors)
    end
  end

  private

  def set_person
    @person = Person.find(params[:person_id])
  rescue ActiveRecord::RecordNotFound
    puts params
    render json: { status: "FAIL", message: "Person not found" }, status: :not_found
  end

  def set_contact
    @contact = @person.contacts.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { status: "FAIL", message: "Contact not found" }, status: :not_found
  end

  def contact_params
    params.require(:contact).permit(:date, :contact_type, :initiated_by, :context)
  end

  def render_success(message, data)
    render json: { status: "SUCCESS", message:, data: }, status: :ok
  end

  def render_created(message, data)
    render json: { status: "SUCCESS", message:, data: }, status: :created
  end

  def render_error(message, errors = {}, status = :unprocessable_entity)
    render json: { status: "FAIL", message:, errors: }, status:
  end
end
