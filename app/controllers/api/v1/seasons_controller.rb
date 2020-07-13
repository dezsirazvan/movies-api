class Api::V1::SeasonsController < Api::V1::BaseController
  skip_before_action :authorize_client!

  def index
    seasons = Season.all.ordered_by_episodes_and_creation
    
    render json: seasons, each_serializer: Api::V1::SeasonSerializer
  end
end