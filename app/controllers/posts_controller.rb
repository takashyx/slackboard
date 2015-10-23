class PostsController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.where(:ts_date => 1.week.ago...Time.now).order(sort_column + ' ' + sort_direction)
  end
  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  def chart_data
    perchannel_data= Array.new
    perchannel_data.push({ name:"All Posts", data: Post.where(:ts_date => 2.week.ago...Time.now).group_by_day(:ts_date).order('ts_date ASC').count })
    render json: perchannel_data
  end

  def perchannel_chart_data
    perchannel_data= Array.new
    Channel.all.each{|c|
      perchannel_data.push({name:c.name, data: Post.where(ch_id: c.ch_id, :ts_date => 2.week.ago...Time.now).group_by_day(:ts_date).order('ts_date ASC').count })
    }
    render json: perchannel_data
  end

  def peruser_chart_data
    peruser_data = Array.new
    User.all.each{|u|
      peruser_data.push({name:u.name+"("+u.profile_real_name+")", data: Post.where(user: u.user_id, :ts_date => 2.week.ago...Time.now).group_by_day(:ts_date).order('ts_date ASC').count })
    }
    render json: peruser_data
  end

  def perweekday_chart_data

    perweekday_data = Array.new

    weekdays = 0..6
    weekdays_table = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']

    per_data = Hash.new
    weekdays_count = Array.new(7, 0)

    posts = Post.where(:ts_date => 1.month.ago...Time.now).group_by_day(:ts_date).order('ts_date ASC').count
    posts.each{|p|
      weekdays_count[Time.at(p[0]).wday] += p[1]
    }
    weekdays.each{|w|
      per_data[weekdays_table.at(w)] = weekdays_count.at(w)
    }

    perweekday_data.push({name:"All Posts", data: per_data})

  render json: perweekday_data
  end

  def perchannel_weekday_chart_data

    perweekday_data = Array.new

    weekdays = 0..6
    weekdays_table = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']

    Channel.all.each{|ch|

      per_data = Hash.new
      weekdays_count = Array.new(7, 0)

      posts = Post.where(ch_id: ch.ch_id, :ts_date => 1.month.ago...Time.now).group_by_day(:ts_date).order('ts_date ASC').count
      posts.each{|p|
        weekdays_count[Time.at(p[0]).wday] += p[1]
      }
      weekdays.each{|w|
        per_data[weekdays_table.at(w)] = weekdays_count.at(w)
      }

      perweekday_data.push({name:ch.name, data: per_data})
    }
    render json: perweekday_data
  end

  def peruser_weekday_chart_data

    perweekday_data = Array.new

    weekdays = 0..6
    weekdays_table = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']

    User.all.each{|u|

      per_data = Hash.new
      weekdays_count = Array.new(7, 0)

      posts = Post.where(user: u.user_id, :ts_date => 1.month.ago...Time.now).group_by_day(:ts_date).order('ts_date ASC').count
      posts.each{|p|
        weekdays_count[Time.at(p[0]).wday] += p[1]
      }
      weekdays.each{|w|
        per_data[weekdays_table.at(w)] = weekdays_count.at(w)
      }

      perweekday_data.push({name:u.name+"("+u.profile_real_name+")", data: per_data})
    }
    render json: perweekday_data
  end

  def perhour_chart_data

    perhour_data = Array.new

    hours = Array(5..23).concat(Array(0..4))
    per_data = Hash.new
    hours_count = Array.new(24, 0)

    posts = Post.where(:ts_date => 1.month.ago...Time.now)
    posts.each{|p|
      hours_count[Time.at(p['ts_date']).hour] += 1
    }

    hours.each{|w|
      per_data["#{w.to_s}:00-#{(w+1).to_s}:00"] = hours_count.at(w)
    }

    perhour_data.push({name:"All Posts", data: per_data})


    render json: perhour_data
  end

  def perhour_user_chart_data

    perhour_data = Array.new

    User.all.each{|u|

      hours = Array(5..23).concat(Array(0..4))
      per_data = Hash.new
      hours_count = Array.new(24, 0)

      posts = Post.where(user: u.user_id, :ts_date => 1.month.ago...Time.now)
      posts.each{|p|
        hours_count[Time.at(p['ts_date']).hour] += 1
      }
      hours.each{|h|
        per_data["#{h.to_s}:00-#{(h+1).to_s}:00"] = hours_count.at(h)
      }

      perhour_data.push({name:"#{u.name}(#{u.profile_real_name})", data: per_data})
    }
    render json: perhour_data
  end

  def perhour_channel_chart_data

    perhour_data = Array.new

    Channel.all.each{|ch|

      hours = Array(5..23).concat(Array(0..4))
      per_data = Hash.new
      hours_count = Array.new(24, 0)


      posts = Post.where(ch_id: ch.ch_id, :ts_date => 1.month.ago...Time.now)
      posts.each{|p|
        hours_count[Time.at(p['ts_date']).hour] += 1
      }
      hours.each{|w|
        per_data["#{w.to_s}:00-#{(w+1).to_s}:00"] = hours_count.at(w)
      }
      perhour_data.push({name:ch.name, data: per_data})
    }
    render json: perhour_data
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:post_type, :user, :text, :ts)
    end

    # sort parameter check
    def sort_direction
       %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end

    #sort index
    def sort_column
      Post.column_names.include?(params[:sort]) ? params[:sort] : "ts"
    end
end
