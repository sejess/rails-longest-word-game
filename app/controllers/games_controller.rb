require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { Array('A'..'Z').sample }.join
  end

  def score
    @letters = params[:letters]
    @word = params[:word].upcase
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{@word}")
    json = JSON.parse(response.read)
    @result = if @word.chars.all? { |letter| @letters.include? letter } # @word can be built out of letters
                if json['found'] # @word is a valid English word
                  "Congratulations! #{@word} is a valid English word!"
                else # @word is not a valid English word
                  "Sorry but #{@word} does not seem to be a valid English word..."
                end
              else
                "Sorry but #{@word} can't be built out of #{@letters}"
              end
  end

  # group :development, :test do
  #   # gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  #   gem 'pry-byebug'
  # end
end
