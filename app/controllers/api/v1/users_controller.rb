class Api::V1::UsersController < Api::V1::BaseController
  skip_before_action :authorize_client!

  before_action :set_user_by_email, only: [:login, :purchase, :library]

  def login
    if @user&.authenticate(params[:password])

      @user.access_tokens.destroy_all

      Doorkeeper::CreateAccessToken.call(user_id: @user.id, scope: 'client')

      @user.reload

      render json: @user, each_serializer: Api::V1::UserSerializer
    else
      render_error_message('Invalid email or password!')
    end
  end

  def movies_and_seasons
    result = {}
    result[:movies] = Movie.all.order(:created_at)
    result[:seasons] = Season.all.order(:created_at)

    render json: result
  end


  def purchase
    if @user.purchases.any?{ |purchase| purchase.movie_id == params[:movie_id].to_i ||  purchase.season_id == params[:season_id].to_i }
      
      render_error_message('You already purchased this one!')
      return
    end

    purchase_object = @user.purchases.create!(
      movie_id: params[:movie_id],
      season_id: params[:season_id],
      quality: params[:quality]
    )

    render json: purchase_object
  end

  def library
    purchases = @user.purchases.in_library

    render json: purchases, each_serializer: Api::V1::PurchaseSerializer
  end

  private

    def set_user_by_email
      @user = User.find_by!(email: params[:email])
    end
end    