class HomeController < ApplicationController
  def index
    @posts = Post.where(:ts_date => 2.week.ago...Time.now)

    peruser_data = Array.new
    perchannel_data= Array.new

    peruser_data.push({ name:"all data", data: Post.where(:ts_date => 2.week.ago...Time.now).group_by_day(:ts_date).order('ts_date ASC').count })
    perchannel_data.push({ name:"all data", data: Post.where(:ts_date => 2.week.ago...Time.now).group_by_day(:ts_date).order('ts_date ASC').count })

    User.all.each{|u|
      peruser_data.push({name:u.name+"("+u.profile_real_name+")", data: Post.where(user: u.user_id, :ts_date => 2.week.ago...Time.now).group_by_day(:ts_date).order('ts_date ASC').count })
    }

    Channel.all.each{|c|
      perchannel_data.push({name:c.name, data: Post.where(channel_id: c.ch_id, :ts_date => 2.week.ago...Time.now).group_by_day(:ts_date).order('ts_date ASC').count })
    }

    @peruser_chart_data = peruser_data
    @perchannel_chart_data = perchannel_data

  end
end
