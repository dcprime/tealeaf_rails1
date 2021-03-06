class PostsController < ApplicationController
  
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show, :fake]
  before_action :check_role, only: [:edit, :update]
  
  def index
    @posts = Post.all.sort_by{|x| x.total_votes}.reverse
  end
  
  def show
    @comment = Comment.new
    
    respond_to do |format|
      format.html
      format.json { render json: @post }
      format.xml  { render xml: @post }
    end
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.creator = current_user
    
    if @post.save
      flash[:notice] = "Your post was created"
      redirect_to posts_path
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    @post.category_ids = params[:category_ids]
    if @post.update(post_params)
      flash[:notice] = "Your post was updated"
      redirect_to posts_path
    else
      render 'edit'
    end
  end
  
  def vote
    @vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])
    respond_to do |format|
      format.html do
        if !@vote.valid?
          flash[:error] = "You already voted on that."
        end
        redirect_to :back 
      end
      format.js 
    end
  end
  
  def fake
    @company_name = Faker::Company.name + ' ' + Faker::Company.suffix
    @company_phrase = Faker::Company.catch_phrase
    @company_bs = Faker::Company.bs
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end
  
  def set_post
    @post = Post.find_by(slug: params[:id])
  end
  
  def check_role
    access_denied unless creator? or current_user.admin?
  end
  
  def creator?
    current_user == @post.creator
  end
end
