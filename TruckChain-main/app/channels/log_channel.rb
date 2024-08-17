# frozen_string_literal: true

class LogChannel < ApplicationCable::Channel
  def subscribed
    stream_from "log_#{params[:order_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end
end
