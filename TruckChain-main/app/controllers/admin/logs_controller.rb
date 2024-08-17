# frozen_string_literal: true

module Admin
  class LogsController < ApplicationController
    # GET /logs
    def index
      @logs = Log.all
    end
  end
end
