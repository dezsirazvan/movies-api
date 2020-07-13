class Api::V1::MoviesController < Api::V1::BaseController

  def index
    render json: {'name': 'movie1'}
  end
end