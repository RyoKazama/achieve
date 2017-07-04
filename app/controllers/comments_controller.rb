class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog
    @notification = @comment.notifications.build(user_id: @blog.user.id)
    respond_to do |format|
         if @comment.save
           # JS形式でレスポンスを返します。
           flash[:notice] = 'コメントを追加しました。'
           format.js { render :index }

           unless @comment.blog.user_id == current_user.id
                Pusher.trigger("user_#{@comment.blog.user_id}_channel", 'comment_created', {
                 message: 'あなたの作成したブログにコメントが付きました'
               })
             end
                Pusher.trigger("user_#{@comment.blog.user_id}_channel", 'notification_created', {
               unread_counts: Notification.where(user_id: @comment.blog.user.id, read: false).count
             })
         else
           # format.html { render :new }
           flash[:notice] = 'コメントを入力してください。'
           format.js { render :index }
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
