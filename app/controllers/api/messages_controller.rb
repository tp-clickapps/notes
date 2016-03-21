class Api::MessagesController < ApplicationController

  # Filters
  before_action      :find_conversation
  before_action      :find_message, only: [:show]
  skip_before_action :verify_authenticity_token


  # GET /api/conversation/:conversation_id/messages
  def index
    if params[:last_fetch] != "null"
      @messages = @conversation.messages.where("id > ?", params[:last_fetch].to_i)
    else
      @messages = @conversation.messages
    end
    render json: { success: true, 
                   messages: ActiveModel::ArraySerializer.new(@messages, each_serializer: MessagesSerializer) }
  end

  # GET /api/conversation/:conversation_id/messages/:id
  def show
    render json: { success: true, message: MessagesSerializer.new(@message) }
  end

  # POST /api/conversation/:conversation_id/messages
  def create
    @message = @conversation.messages.new message_params
    @message.user = current_user
    if @message.save
      render json: { success: true, message: MessagesSerializer.new(@message) }
    else
      render json: { success: false, errors: @message.errors.full_messages.join(", ") }
    end
  end


  private

  # Find Conversation object to find the related messages from different actions
  def find_conversation
    @conversation = Conversation.find params[:conversation_id]
  end 

  # Find Message object for the actions specified in the filter
  def find_message
    @message = @conversation.messages.find params[:id]
  end

  # We need to define here the parameters which are allowed from external apps/PL
  def message_params
    params.require(:message).permit(:body)
  end

end
