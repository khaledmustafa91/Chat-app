class Applications::ChatsController < Applications::BaseController
  before_action :set_application
  before_action :set_chat, only: [:show]

  # GET /applications/:application_token/chats
  def index
    @chats = @application.chats

    paginate collection: @chats
  end

  # GET /applications/:application_token/chats/1
  def show
    render json: @chat
  end

  # POST /applications/:application_token/chats
  def create
    Producer::Chats.new.publish({ application_token: @application.token })
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = @application.chats.find_by_chat_number!(params[:number])
    end
end
