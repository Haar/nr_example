class PagesController < ApplicationController

  before_filter -> { redirect_to posts_path if user_signed_in? }

  def home
  end
end
