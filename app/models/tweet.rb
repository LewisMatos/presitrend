class Tweet < ActiveRecord::Base
  
  TweetStream.configure do |config|
    config.consumer_key        = ENV['TWITTER_KEY']
    config.consumer_secret     = ENV['TWITTER_SECRET'] 
    config.oauth_token         = ENV['OAUTH_KEY']
    config.oauth_token_secret  = ENV['OAUTH_SECRET']
    config.auth_method         = :oauth
  end
 def self.demo
  state_abrev = {
    AK: "Alaska",
    AL: "Alabama",
    AR: "Arkansas",
    AZ: "Arizona",
    CA: "California",
    CO: "Colorado",
    CT: "Connecticut",
    DE: "Delaware",
    FL: "Florida",
    GA: "Georgia",
    HI: "Hawaii",
    IA: "Iowa",
    ID: "Idaho",
    IL: "Illinois",
    IN: "Indiana",
    KS: "Kansas",
    KY: "Kentucky",
    LA: "Louisiana",
    MA: "Massachusetts",
    MD: "Maryland",
    ME: "Maine",
    MI: "Michigan",
    MN: "Minnesota",
    MO: "Missouri",
    MS: "Mississippi",
    MT: "Montana",
    NC: "North Carolina",
    ND: "North Dakota",
    NE: "Nebraska",
    NH: "New Hampshire",
    NJ: "New Jersey",
    NM: "New Mexico",
    NV: "Nevada",
    NY: "New York",
    OH: "Ohio",
    OK: "Oklahoma",
    OR: "Oregon",
    PA: "Pennsylvania",
    RI: "Rhode Island",
    SC: "South Carolina",
    SD: "South Dakota",
    TN: "Tennessee",
    TX: "Texas",
    UT: "Utah",
    VA: "Virginia",
    VT: "Vermont",
    WA: "Washington",
    WI: "Wisconsin",
    WV: "West Virginia",
    WY: "Wyoming"
}



  candidates =  Candidate.all
  rawtweet = Rawtweet.all
  #states =  Popcounter.column_names
  while true
    candidates.each_with_index do |can_obj,index|
    rawtweet.each do |rtweet|
       tweethash =  JSON.parse(rtweet.tweet)
       sname = Sanitize.clean(tweethash[:user][:screen_name])
       stext = Sanitize.clean(tweethash[:text])  
       slocation = Sanitize.clean(tweethash[:user][:location])
       if stext =~ "#{can_obj.name}"
        if sabrev = state_abrev.find {|key,value| slocation =~ /#{key.to_s}/i || slocation =~ /#{value}/i}.first
        tweet = Tweet.create(username: sname,tweet: stext,location: sabrev.to_s,candidate: can_obj.name,candidate_id: can_obj.id)
        tweet.save
            end
            end

        end
    end
  end
 end

#       begin
#         Timeout::timeout(20) {
#         @start_time = Time.now
#         TweetStream::Client.new.track(can_obj.name) do |t|
#             sname = Sanitize.clean(t.attrs[:user][:screen_name])
#             stext = Sanitize.clean(t.attrs[:text])  
#             slocation = Sanitize.clean(t.attrs[:user][:location])
#           #  binding.pry
#            if sabrev = state_abrev.find {|key,value| slocation =~ /#{key.to_s}/i || slocation =~ /#{value}/i}.first
#             rawtweet = Rawtweet.create(tweet: t.attrs)
#             rawtweet.save
#             tweet = Tweet.create(username: sname,tweet: stext,location: sabrev.to_s,candidate: can_obj.name,candidate_id: can_obj.id)
#             tweet.save
#               Popcounter.where(:candidate_id => can_obj.id).update_all("#{sabrev.to_s} = #{sabrev.to_s} + 1")
# puts "NAME => #{sname} TEXT => #{stext} LOCATION => #{sabrev.to_s} CANDIDATE => #{can_obj.name} CANDIDATE_ID => #{can_obj.id}"
#             end
            
#             puts "CURRENT TIME IS #{Time.now.strftime("%Y-%m-%d %I:%M:%S %p")}"
#       end 
#         } 
#     rescue Timeout::Error
#       puts "RESCUED #{can_obj.name.upcase}"
#     end





 def self.stream
  state_abrev = {
    AK: "Alaska",
    AL: "Alabama",
    AR: "Arkansas",
    AZ: "Arizona",
    CA: "California",
    CO: "Colorado",
    CT: "Connecticut",
    DE: "Delaware",
    FL: "Florida",
    GA: "Georgia",
    HI: "Hawaii",
    IA: "Iowa",
    ID: "Idaho",
    IL: "Illinois",
    IN: "Indiana",
    KS: "Kansas",
    KY: "Kentucky",
    LA: "Louisiana",
    MA: "Massachusetts",
    MD: "Maryland",
    ME: "Maine",
    MI: "Michigan",
    MN: "Minnesota",
    MO: "Missouri",
    MS: "Mississippi",
    MT: "Montana",
    NC: "North Carolina",
    ND: "North Dakota",
    NE: "Nebraska",
    NH: "New Hampshire",
    NJ: "New Jersey",
    NM: "New Mexico",
    NV: "Nevada",
    NY: "New York",
    OH: "Ohio",
    OK: "Oklahoma",
    OR: "Oregon",
    PA: "Pennsylvania",
    RI: "Rhode Island",
    SC: "South Carolina",
    SD: "South Dakota",
    TN: "Tennessee",
    TX: "Texas",
    UT: "Utah",
    VA: "Virginia",
    VT: "Vermont",
    WA: "Washington",
    WI: "Wisconsin",
    WV: "West Virginia",
    WY: "Wyoming"
}



  candidates =  Candidate.all
  #states =  Popcounter.column_names
  while true
    candidates.each_with_index do |can_obj,index|
      begin
        Timeout::timeout(20) {
        @start_time = Time.now
        TweetStream::Client.new.track(can_obj.name) do |t|
            sname = Sanitize.clean(t.attrs[:user][:screen_name])
            stext = Sanitize.clean(t.attrs[:text])  
            slocation = Sanitize.clean(t.attrs[:user][:location])
          #  binding.pry
           if sabrev = state_abrev.find {|key,value| slocation =~ /#{key.to_s}/i || slocation =~ /#{value}/i}.first
            rawtweet = Rawtweet.create(tweet: t.attrs)
            rawtweet.save
            tweet = Tweet.create(username: sname,tweet: stext,location: sabrev.to_s,candidate: can_obj.name,candidate_id: can_obj.id)
            tweet.save
              Popcounter.where(:candidate_id => can_obj.id).update_all("#{sabrev.to_s} = #{sabrev.to_s} + 1")
puts "NAME => #{sname} TEXT => #{stext} LOCATION => #{sabrev.to_s} CANDIDATE => #{can_obj.name} CANDIDATE_ID => #{can_obj.id}"
            end
            
            puts "CURRENT TIME IS #{Time.now.strftime("%Y-%m-%d %I:%M:%S %p")}"
      end 
        } 
    rescue Timeout::Error
      puts "RESCUED #{can_obj.name.upcase}"
    end
    end
  end
 end
end





