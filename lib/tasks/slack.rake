require 'net/http'
require 'uri'
require 'json'

namespace :slack do

  desc "update channel list"
  task :update_channels => :environment do
    # TODO: read token from config file
    uri = get_json('https://slack.com/api/channels.list?token=' + Rails.application.secrets.slack_token)
    if uri["ok"] == true then

      puts '=============='

      for ch in uri["channels"]

        if Channel.find_by( ch_id: ch["id"] ) == nil then

          puts ''
          puts '!!! NEW CHANNEL !!!'
          puts ''

          Channel.create(ch_id: ch['id'],
            name: ch['name'],
            created: ch['created'],
            creator: ch['creator'],
            is_archived: ch['is_archived'],
            num_members: ch['num_members'],
            topic_value: ch['topic']['value'],
            topic_creator: ch['topic']['creator'],
            topic_last_set: ch['topic']['last_set'],
            purpose_value: ch['purpose']['value'],
            purpose_creator: ch['purpose']['creator'],
            purpose_last_set: ch['purpose']['last_set'])
        end

        puts ch["id"]

        # if id is not in the db
        # add new

        # TODO handle these info:
        puts ch["name"]
        puts ch["is_channel"]
        puts ch["created"]
        puts ch["is_archived"]
        puts ch["is_general"]
        puts ch["is_member"]
        for m in ch["members"]
          print "- "
          puts m
        end
        puts ch["topic"]
        puts ch["purpose"]
        puts ch["num_members"]
        puts '=============='
      end
    end
  end

  desc "update posts"
  task :update_posts => :environment do
    if Channel.count == 0 then
      puts 'No channels listed. please perform "rake handle_channel_info:update_list_of_channels" first.'
    else
      for ch in Channel.all
        # TODO: read token from config file
        uri=get_json("https://slack.com/api/channels.history?token=" + Rails.application.secrets.slack_token + "&channel="+ch['ch_id'])
        if uri['ok'] == true then

          puts '=============='

          for m in uri['messages']

            if m['type'] == "message" and Post.find_by( ts: m["ts"] ) == nil then

              puts ''
              puts '!!! NEW POST !!!'
              puts ''

              Post.create(
                 post_type: m['type'],
                 user: m['user'],
                 text: m['text'],
                 ts:   m['ts'],
                 ts_date: Time.at(m['ts'].split(".",2)[0].to_i)
              )

            end
            puts m['type']
            puts m['user']
            puts m['text']
            puts m['ts']
            puts '=============='

          end
        end
      end
      #TODO: if uri['has_more'] == true then
      # do it again

      # wait for API call for next channel
      sleep(3)
    end
  end

  desc "update stars"
  task :update_stars => :environment do
    # TODO: read token from config file
    for u in User.all
      uri=get_json("https://slack.com/api/stars.list?token=" + Rails.application.secrets.slack_token + "&user="+u['user_id'])
      if uri['ok'] == true then

        puts '=============='

        for m in uri['items']

          # TODO: handle starred channels, files, and so on...
          if m['type'] == "message" then
            if StarredPost.find_by( ts: m["message"]["ts"], starred_by: u['user_id'] ) == nil then
              puts ''
              puts '!!! NEW POST !!!'
              puts ''

              StarredPost.create(
                                 post_type: m['type'],
                                 user: m['message']['user'],
                                 text: m['message']['text'],
                                 ts:   m['message']['ts'],
                                 ts_date: Time.at(m['message']['ts'].split(".",2)[0].to_i),
                                 starred_by: u['user_id'])
            end

            puts m['type']
            puts m['message']['user']
            puts m['message']['text']
            puts m['message']['ts']
            puts '---'
            puts u['user_id']
            puts '=============='
          end
        end
      end
      # TODO: if uri['has_more'] == true then
      # do it again

      # wait for API call for next channel
      sleep(3)
    end
  end

  desc "update user list"
  task :update_users => :environment do
    # TODO: read token from config file
    uri = get_json('https://slack.com/api/users.list?token=' + Rails.application.secrets.slack_token)

    if uri["ok"] == true then

      puts '=============='

      for u in uri["members"]


        if User.find_by( user_id: u["id"] ) == nil then

          puts ''
          puts '!!! NEW USER !!!'
          puts ''
          User.create(user_id: u['id'],
            name: u['name'],
            deleted: u['deleted'],
            color: u['color'],
            profile_first_name: u['profile']['first_name'],
            profile_last_name: u['profile']['last_name'],
            profile_real_name: u['profile']['real_name'],
            profile_email: u['profile']['email'],
            profile_skype: u['profile']['skype'],
            profile_phone: u['profile']['phone'],
            profile_image_24: u['profile']['image_24'],
            profile_image_32: u['profile']['image_32'],
            profile_image_48: u['profile']['image_48'],
            profile_image_72: u['profile']['image_72'],
            profile_image_192: u['profile']['image_192'],
            is_admin: u['is_admin'],
            is_owner: u['is_owner'],
            has_files: u['has_files'])
        end

        # if id is not in the db
        # add new

        # TODO handle these info:
        puts u['id']
        puts u['name']
        puts u['deleted']
        puts u['color']
        puts u['profile_first_name']
        puts u['profile_last_name']
        puts u['profile_real_name']
        puts u['profile_email']
        puts u['profile_skype']
        puts u['profile_phone']
        puts u['profile_iamge_24']
        puts u['profile_iamge_32']
        puts u['profile_iamge_48']
        puts u['profile_iamge_72']
        puts u['profile_iamge_192']
        puts u['is_admin']
        puts u['is_owner']
        puts u['has_fiels']
        puts '=============='
      end
    end
  end
end

##
# helper fuction to get json obj
#
def get_json(location, limit = 10)
  raise ArgumentError, 'too many HTTP redirects' if limit == 0
  uri = URI.parse(location)
  begin
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.open_timeout = 5
      http.read_timeout = 10
      http.get(uri.request_uri)
    end
    case response
    when Net::HTTPSuccess
      json = response.body
      JSON.parse(json)
    when Net::HTTPRedirection
      location = response['location']
      warn "redirected to #{location}"
      get_json(location, limit - 1)
    else
      puts [uri.to_s, response.value].join(" : ")
      # handle error
    end
  rescue => e
    puts [uri.to_s, e.class, e].join(" : ")
    # handle error
  end
end
