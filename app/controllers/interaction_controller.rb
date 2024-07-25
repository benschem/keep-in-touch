class InteractionsController < ApplicationController
  before_action :set_person, only: %i[create update destroy]
  before_action :set_interaction, only: %i[update destroy]

  # POST /people/1/interactions
  def create
    @interaction = @person.interactions.new(interaction_params)
    if @interaction.save
      redirect_to @person, notice: 'Interaction was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /people/1/interactions/1
  def update
    if @interaction.update(interaction_params)
      redirect_to @person, notice: 'Interaction was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /people/1/interactions/1
  def destroy
    if @interaction.destroy
      redirect_to @person, notice: 'Interaction was successfully destroyed.'
    else
      redirect_to @person, alert: 'Interaction could not be destroyed.'
    end
  end

  private

  def set_person
    @person = Person.includes(:interactions).find(params[:person_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to people_path, alert: 'Person not found.'
  end

  def set_interaction
    @interaction = @person.interactions.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to @person, alert: 'Interaction not found.'
  end

  def interaction_params
    params.require(:interaction).permit(:date, :method, :initiated_by, :context)
  end
end
