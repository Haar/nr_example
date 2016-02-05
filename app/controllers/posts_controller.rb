class PostsController < ApplicationController
  resource :posts

  def resource_params
    params.require(:post).permit()
  end

end
