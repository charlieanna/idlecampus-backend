# app/models/question.rb
require 'net/http'
require 'json'

class Question < ApplicationRecord
  belongs_to :lesson
  has_many :user_questions
  has_many :users, through: :user_questions

  def score_question(user_tags)
    matching_tags_score = (self.tags & user_tags).count
    inlinks_score = self.inlinks
    outlinks_score = self.outlinks
    popularity_score = self.score
    
    # Weight the scores as you see fit
    total_score = matching_tags_score * 2 + inlinks_score * 1 + outlinks_score * 1 + popularity_score * 3
    
    total_score
  end

  def self.tagged_with(tags)
    begin
      # Constructing the URL for the HTTP GET request
      tags_param = tags.join(",")
      uri = URI("http://stackoverflow:5000/posts/#{tags_param}")
  
      # Making the HTTP GET request
      response = Net::HTTP.get_response(uri)
  
      # Check if the request was successful
      if response.is_a?(Net::HTTPSuccess)
        # Assuming the response is a JSON object containing the questions
        return JSON.parse(response.body)['questions']
      else
        puts "Failed to retrieve questions for tags #{tags}: #{response.code}"
        return nil
      end
    rescue => e
      puts "An error occurred while fetching questions for tags #{tags}: #{e.message}"
      return nil
    end
  end
end