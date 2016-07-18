class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
      @article = Article.new

  end

  def edit
    #@article = Article.find(params[:id])  ---> moved to method set_article
  end

  def create
    #render plain: params[:article].inspect     # for testing purpose
    @article = Article.new(article_params)
    @article.user = User.first
    if @article.save
      flash[:success] = "Article was successfully created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def update
    #@article = Article.find(params[:id])  ---> moved to method set_article

    if @article.update(article_params)
      flash[:success] = "Article was updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end


  def show
    #@article = Article.find(params[:id])  ---> moved to method set_article
  end

  def destroy
    #@article = Article.find(params[:id])  ---> moved to method set_article
    @article.destroy
    flash[:success] = "Article was deleted sucessfully"
    redirect_to article_path
  end

  private

    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description)
    end


end
