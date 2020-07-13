class Api::V1::MoviesController < Api::V1::BaseController
  skip_before_action :authorize_client!

  def index
    movies = Movie.all_cached

    render json: movies
  end
end