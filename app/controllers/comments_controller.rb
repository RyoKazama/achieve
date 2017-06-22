class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog
    respond_to do |format|
         if @comment.save
           format.html { redirect_to blog_path(@blog), notice: 'コメントを投稿しました。 ' }
           # JS形式でレスポンスを返します。
           flash[:notice] = 'コメントを追加しました。'
           format.js { render :index }
         else
           format.html { render :new }
         end
       end
     end

  def destroy
    @comment=Comment.find(params[:id])
    flash[:notice] = 'コメントを削除しました。'
    respond_to do |format|
         @comment.destroy
           format.js { render :index }
         end
  end

  private

  def comment_params
        params.require(:comment).permit(:blog_id, :content)
  end

end
