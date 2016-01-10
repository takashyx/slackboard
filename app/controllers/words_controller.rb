class WordsController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_word, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @words = Word.all
    @words_top_hundred = Word.all.where(:ignore_flag  => [false, nil]).order(sort_column + ' ' + sort_direction).limit(10)
    @words_ignored = Word.all.where(:ignore_flag => true).order(sort_column + ' ' + sort_direction)
  end

  def show
  end

  def new
    @word = Word.new
  end

  def edit
  end

  def toggle_ignore_flag
    @word = Word.find(id)
    if @word.ignore_flag == true
      @word.update_column(:ignore_flag, :false)
    else
      @word.update_column(:ignore_flag, :true)
    end
    redirect_to_index
  end

  def create
    @word = Word.new(word_params)
    @word.save
  end

  def update
    @word.update_attributes(word_params)
    respond_with(@word)
  end

  def destroy
    @word.destroy
    respond_with(@word)
  end

  private
    def set_word
      @word = Word.find(params[:id])
    end

    def word_params
      params.require(:word).permit(:word, :count, :ignore_flag, :last_post_id)
    end

    # sort parameter check
    def sort_direction
       %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end

    #sort index
    def sort_column
      Word.column_names.include?(params[:sort]) ? params[:sort] : "count"
    end
end
