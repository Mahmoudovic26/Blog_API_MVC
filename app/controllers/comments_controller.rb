class CommentsController < ApplicationController
    def create
      @article = Article.find(params[:article_id])
      @comment = @article.comments.build(comment_params)
  
      respond_to do |format|
        if @comment.save
          format.html { redirect_to article_path(@article), notice: 'Comment was successfully created.' }
          format.json { render json: @comment, status: :created, location: [@article, @comment] }
        else
          format.html { redirect_to article_path(@article), alert: 'Error creating comment.' }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
  end