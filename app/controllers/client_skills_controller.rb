class ClientSkillsController < ApplicationController
  before_action :set_client_skill, only: [:show, :update, :destroy]

  # GET /client_skills
  def index
    @client_skills = ClientSkill.all

    render json: @client_skills
  end

  # GET /client_skills/1
  def show
    render json: @client_skill
  end

  # POST /client_skills
  def create
    @client_skill = ClientSkill.new(client_skill_params)

    if @client_skill.save
      render json: @client_skill, status: :created, location: @client_skill
    else
      render json: @client_skill.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /client_skills/1
  def update
    if @client_skill.update(client_skill_params)
      render json: @client_skill
    else
      render json: @client_skill.errors, status: :unprocessable_entity
    end
  end

  # DELETE /client_skills/1
  def destroy
    @client_skill.destroy
  end
  
  # GET getClientSkills?clientId={cid}
  def getClientSkills
    @skills = ClientSkill.where(:client_id => params[:clientId])
    
    render json: @skills
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_skill
      @client_skill = ClientSkill.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_skill_params
      params.require(:client_skill).permit(:client_id, :skill, :notes)
    end
end
