class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index

    if params[:map_id]
      @map_list = Map.all
      @map = Map.find(params[:map_id])
      @articles = @map.articles.order(created_at: :desc).page(params[page]).per(8)
      @articles_side = Article.order(created_at: :desc)
    else
      @map_list = Map.all
      @articles = Article.order(created_at: :desc).page(params[:page]).per(8)
      @articles_side = Article.order(created_at: :desc)
    end
    respond_to do |format|
      format.html
      format.rss { render :layout => false }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    @tag_list = @article.maps.pluck(:tag_name).join(",")
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    tag_list = params[:article][:tag_name].split(",")

    respond_to do |format|
      if @article.save
        @article.save_articles(tag_list)
        format.html { redirect_to @article, notice: '記事を投稿しました' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    @article = Article.new(article_params)
    tag_list = params[:article][:tag_name].split(",")
    respond_to do |format|
      if @article.update(article_params)
        @article.save_articles(tag_list)
        format.html { redirect_to @article, notice: '記事を編集しました' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content, :image)
    end
end
