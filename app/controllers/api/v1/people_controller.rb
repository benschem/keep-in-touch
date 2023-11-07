class Api::V1::PeopleController < ApplicationController
  before_action :set_person, only: %i[show update destroy]

  # GET /people
  def index
    @people = Person.includes(:contacts).all
    render_success("People fetched successfully", @people)
  end

  # GET /people/1
  def show
    render_success("Person fetched successfully", @person)
  end

  # POST /people
  def create
    @person = Person.new(person_params)
    if @person.save
      render_created("Person created successfully", @person)
    else
      render_error("Person cannot be created", @person.errors)
    end
  end

  # PATCH/PUT /people/1
  def update
    if @person.update(person_params)
      render_success("Person updated successfully", @person)
    else
      render_error("Person cannot be updated", @person.errors)
    end
  end

  # DELETE /people/1
  def destroy
    if @person.destroy
      render_success("Person deleted successfully", nil)
    else
      render_error("Person cannot be deleted", @person.errors)
    end
  end

  private

  def set_person
    @person = Person.includes(:contacts).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { status: "FAIL", message: "Person not found" }, status: :not_found
  end

  def person_params
    params.require(:person).permit(:name, :relationship)
  end

  def render_success(message, data)
    render json: {
      status: "SUCCESS",
      message:,
      data: data.as_json(except: %i[created_at updated_at],
                         include: { contacts: { except: %i[created_at updated_at],
                                                methods: :formatted_date } })
    }, status: :ok
  end

  def render_created(message, data)
    render json: { status: "SUCCESS", message:, data: }, status: :created
  end

  def render_error(message, errors = {}, status = :unprocessable_entity)
    render json: { status: "FAIL", message:, errors: }, status:
  end
end
