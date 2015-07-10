class StarredPostsController < ApplicationController
  before_action :set_starred_post, only: [:show, :edit, :update, :destroy]

  # GET /starred_posts
  # GET /starred_posts.json
  def index
    @starred_posts = StarredPost.all

    data = Array.new
    data.push({ name:"all data", data: StarredPost.group_by_day(:ts_date).order('ts_date ASC').count })
    User.all.each{|u|
      data.push({name:u.name+"("+u.profile_real_name+")", data: StarredPost.where(user: u.user_id).group_by_day(:ts_date).order('ts_date ASC').count })
    }
    @chart_data = data
  end

  # GET /starred_posts/1
  # GET /starred_posts/1.json
  def show
  end

  # GET /starred_posts/new
  def new
    @starred_post = StarredPost.new
  end

  # GET /starred_posts/1/edit
  def edit
  end

  # POST /starred_posts
  # POST /starred_posts.json
  def create
    @starred_post = StarredPost.new(starred_post_params)

    respond_to do |format|
      if @starred_post.save
        format.html { redirect_to @starred_post, notice: 'Starred post was successfully created.' }
        format.json { render :show, status: :created, location: @starred_post }
      else
        format.html { render :new }
        format.json { render json: @starred_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /starred_posts/1
  # PATCH/PUT /starred_posts/1.json
  def update
    respond_to do |format|
      if @starred_post.update(starred_post_params)
        format.html { redirect_to @starred_post, notice: 'Starred post was successfully updated.' }
        format.json { render :show, status: :ok, location: @starred_post }
      else
        format.html { render :edit }
        format.json { render json: @starred_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /starred_posts/1
  # DELETE /starred_posts/1.json
  def destroy
    @starred_post.destroy
    respond_to do |format|
      format.html { redirect_to starred_posts_url, notice: 'Starred post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_starred_post
      @starred_post = StarredPost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def starred_post_params
      params.require(:starred_post).permit(:post_type, :ts, :user, :text)
    end
end
