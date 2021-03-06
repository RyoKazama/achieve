class BlogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_blog, only: [:edit, :update, :destroy, :show]


  def index
    @blogs = Blog.all
  end

  def show
    set_blog
     @comment = @blog.comments.build
     @comments = @blog.comments

     Notification.find(params[:notification_id]).update(read:true) if params[:notification_id]
   end


  def new
    if params[:back]
      @blog = Blog.new(blogs_params)
    else
      @blog=Blog.new
    end
  end

  def create
    @blog=Blog.create(blogs_params)
    @blog.user_id = current_user.id
    @blog.user_name = current_user.name
    if @blog.save
      redirect_to blogs_path, notice: "ブログを作成しました！"
      NoticeMailer.sendmail_blog(@blog).deliver
      else
      render 'new'
    end
  end

  def edit
  set_blog
  end

  def update
  set_blog
  @blog.update(blogs_params)
    if @blog.save
    redirect_to blogs_path, notice: "ブログを更新しました！"
      else
    render 'edit'
    end
  end

  def destroy
  set_blog
  @blog.destroy
    redirect_to blogs_path, notice:"ブログを削除しました！"
  end

  def confirm
  @blog=Blog.new(blogs_params)
  render :new if @blog.invalid?
  end


  private
    def blogs_params
      params.require(:blog).permit(:title,:content)
    end

    def set_blog
          @blog=Blog.find(params[:id])
    end

end
