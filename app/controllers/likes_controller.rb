class LikesController < ApplicationController

  before_action :authenticate_user!

  def create
    @like = current_user.likes.build(like_params)
    @post = @like.post
    if @like.save
      respond_to :js
    
  end
end

def destroy
  @like = Like.find_by(id: params[:id])
  @post = @like.post
  if @like.destroy
    respond_to :js
  end  
end

  private
  def like_params
    params.permit(:post_id)
    #params:送られてきたリクエスト情報を一まとめにしたもの
    #permit:変更を加えられるキーを指定する

    
  end

end
