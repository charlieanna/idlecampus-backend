# namespace :questions do
#   desc "This task sends a list of questions"
#   task :list => :environment do
#     User.all.each do |user|
#       UserMailer.questions_list(user).deliver_now
#     end
#   end
# end

# namespace :summary do
#   desc "This task sends a list of questions"
#   task :list => :environment do
#     User.all.each do |user|
#       UserMailer.day_summary(user).deliver_now
#     end
#   end
# end


# namespace :topics do
#   desc "This task sends a list of questions"
#   task :notification => :environment do
#     User.all.each do |user|
#       UserMailer.notifier(user).deliver_now
#     end
#   end
# end

namespace :questions do
  desc "This task sends a list of questions"
  task :update => :environment do
    require 'net/http'
    require 'uri'

    uri = URI('https://localhost:3009/update_all')
    res = Net::HTTP.get_response(uri)
    puts res.body if res.is_a?(Net::HTTPSuccess)
  end
end

# import threading
# import requests
# def printit():
#   threading.Timer(10, printit).start()
#   r =requests.get('http://localhost:3009/update_all')
#   print(r.status_code)