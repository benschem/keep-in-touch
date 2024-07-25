class PeopleController < ApplicationController
  before_action :set_person, only: %i[show update destroy]

  # GET /people
  def index
    @people = Person.includes(:interactions).all
  end

  # GET /people/1
  def show
  end

  # POST /people
  def create
    @person = Person.new(person_params)

    if @person.save
      redirect_to @person, notice: 'Person was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /people/1
  def update
    if @person.update(person_params)
      redirect_to @person, notice: 'Person was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /people/1
  def destroy
    if @person.destroy
      redirect_to people_url, notice: 'Person was successfully deleted.'
    else
      redirect_to @person, notice: 'Person could not be deleted.'
    end
  end

  private

  def set_person
    @person = Person.includes(:interactions).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to people_url, alert: 'Person not found.'
  end

  def person_params
    params.require(:person).permit(:name, :relationship)
  end
end
