class CommentsController < ApplicationController
  
  before_action :require_user
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit (:body))
    @comment.creator = current_user
    
    if @comment.save
      flash[:notice] = "Your comment was added"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end
  
  def vote
    comment = Comment.find(params[:id])
    @vote = Vote.create(voteable: comment, creator: current_user, vote: params[:vote])
    if !@vote.save
      flash[:error] = "You already voted on that."
    end
    redirect_to :back
  end
  
end