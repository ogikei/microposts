class RetweetsController < ApplicationController
  def create
    @micropost = Micropost.find(params[:micropost_id])
    @retweet = current_user.retweets.build(micropost: @micropost)
    @retweeted_micropost = Micropost.new content: @micropost.content,
                                         user_id: current_user.id,
                                         original_micropost_id: @micropost.id,
                                         original_user_name: @micropost.user.name
    if @retweet.save && @retweeted_micropost.save
      flash[:success] = "Retweet Successed!"
      redirect_to root_url
    else
      flash[:danger] = "Retweet Failed!"
      redirect_to request.referer
    end
  end
end
