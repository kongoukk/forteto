class Public::HomesController < ApplicationController
   before_action :authenticate_with_http_digest, only: [:top]

  def top
    @current_user = current_user
  end

  def about
  end
end
