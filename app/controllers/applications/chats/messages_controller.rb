class Applications::Chats::MessagesController < Applications::BaseController
  before_action :set_application
  before_action :set_chat
  before_action :set_message, only: %i[show update]

  # GET /applications/:application_token/chats/:chat_number/messages
  def index
    @messages = @chat.messages

    paginate collection: @messages
  end

  def search
    @messages = @chat.messages.search(
      params[:query] || '*',
      page: params[:page],
      per_page: params[:per_page]
    )

    paginate_elasticsearch collection: @messages
  end

  # GET /applications/:application_token/chats/:chat_number/messages/1
  def show
    render json: @message
  end

  # POST /applications/:application_token/chats/:chat_number/messages
  def create
    Producer::Messages.new.publish(message_params.merge(chat_id: @chat.id))
  end

  # PATCH/PUT /applications/:application_token/chats/:chat_number/messages/1
  def update
    Producer::Messages.new.publish(
      message_params.merge(message_number: @message.message_number, chat_id: @message.chat.id))
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_chat
    @chat = @application.chats.find_by_chat_number!(params[:chat_number])
  end

  def set_message
    @message = @chat.messages.find_by_message_number!(params[:number])
  end

  # Only allow a trusted parameter "white list" through.
  def message_params
    params.require(:message).permit(:body)
  end
end
