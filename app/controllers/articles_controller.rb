class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
    respond_to do |format|
      format.html # This will render your existing view
      format.json { render json: @articles.to_json(include: :comments) }
    end
  end

  def show
    respond_to do |format|
      format.html # This will render your existing view
      format.json { render json: @article.to_json(include: :comments) }
    end
  end

  def new 
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
        format.json { render json: @article.to_json(include: :comments), status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit 
  end

  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
        format.json { render json: @article.to_json(include: :comments), status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }    
      end
    end
  end

  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_article
    @article = Article.includes(:comments).find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end
end