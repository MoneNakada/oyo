class ChatsController < ApplicationController
  def chat
     @user = User.find(params[:user_id])
     @chat = Chat.new
     @chats = Chat.all
  end

  def create
    @user = User.find(params[:user_id])
    @chat = Chat.new(chat_params)
    @chat.save
    redirect_to request.referer
  end

  private
  def chat_params
    params.require(:chat).permit(:body)
  end
end
