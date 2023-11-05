class Api::V1::PeopleController < ApplicationController
  before_action :set_person, only: %i[show update destroy]

  # GET /people
  def index
    @people = Person.all

    if @people
      render json: { status: "SUCCESS", message: "All the people fetched successfully", data: @people }, status: :ok
    else
      # render json: @people.errors, status: :bad_request
      render json: { status: "FAIL", message: "People cannot be fetched" }, status: :unprocessable_entity
    end
  end

  # GET /people/1
  def show
    if @person
      render json: { status: "SUCCESS", message: "Person fetched successfully", data: @person }, status: :ok
    else
      # render json: @person.errors, status: :bad_request
      render json: { status: "FAIL", message: "Person cannot be fetched" }, status: :unprocessable_entity
    end
  end

  # POST /people
  def create
    @person = Person.new(person_params)

    if @person.save
      render json: { status: "SUCCESS", message: "Person created successfully", data: @person }, status: :created
    else
      # render json: @person.errors, status: :unprocessable_entity
      render json: { status: "FAIL", message: "Person cannot be created" }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /people/1
  def update
    if @person.update!(person_params)
      render json: { status: "SUCCESS", message: "Person updated successfully", data: @person }, status: :ok
    else
      # render json: @person.errors, status: :unprocessable_entity
      render json: { status: "FAIL", message: "Person cannot be updated" }, status: :unprocessable_entity
    end
  end

  # DELETE /people/1
  def destroy
    if @person.destroy!
      render json: { status: "SUCCESS", message: "Person deleted successfully" }, status: :ok
    else
      # render json: @person.errors, status: :bad_request
      render json: { status: "FAIL", message: "Person cannot be deleted" }, status: :bad_request
    end
  end

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:name, :relationship)
  end
end
