class BirdsController < ApplicationController

  # GET /birds
  def index
    birds = Bird.all
    render json: birds
  end

  # POST /birds
  def create
    bird = Bird.create(bird_params)
    render json: bird, status: :created
  end

  # GET /birds/:id
  def show
    bird = Bird.find_by(id: params[:id])
    if bird
      render json: bird
    else
      render json: { error: "Bird not found" }, status: :not_found
    end
  end

  # PATCH /birds/:id
  def update
    bird = Bird.find_by(id: params[:id])
    if bird
      bird.update(bird_params)
      render json: bird
    else
      render json: { error: "Bird not found" }, status: :not_found
    end
  end

  # PATCH /birds/:id/like
  def increment_likes
    bird = Bird.find_by(id: params[:id])
    if bird
      bird.update(likes: bird.likes + 1)
      render json: bird
    else
      render json: { error: "Bird not found" }, status: :not_found
    end
  end

   #DELETE /birds/:id

   def destroy
   bird = find_a_bird
   bird.destroy
   head :no_content #This is the bit that responds to the frontend that the delete was successful since there usually no data sent back after a delete functionality
   #A 204 ststus code is returned to the client
  rescue ActiveRecord::RecordNotFound
    send_error
   end

  private

  def bird_params
    params.permit(:name, :species, :likes)
  end

  def find_a_bird
    bird = Bird.find(params[:id])
  end

  def send_error
  render json: {error: "Bird not found!"}
  end
end
