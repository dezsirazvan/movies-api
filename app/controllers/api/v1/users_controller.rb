class Api::V1::UsersController < Api::V1::BaseController
  skip_before_action :authorize_client!

  before_action :set_user_by_email

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

  private

    def set_user_by_email
      @user = User.find_by(email: params[:email])
    end
end    