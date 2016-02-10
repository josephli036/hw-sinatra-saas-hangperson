class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess letter
    if letter == '' or letter == nil or letter.match(/[a-zA-Z]/).nil?
      raise ArgumentError, "Invalid guess"
    elsif !@wrong_guesses.match(/.*#{letter}.*/i).nil? or !@guesses.match(/.*#{letter}.*/i).nil?
      return false
    end
    if @word.match(/.*#{letter}.*/i).nil?
      @wrong_guesses += letter
    else
      @guesses += letter
    end
    return true
  end
  
  def word_with_guesses
    tmp = ''
    @word.each_char do |c|
      if !@guesses.match(/#{c}/).nil?
        tmp += c
      else
         tmp += "-"
      end
    end
    return tmp
  end
  
  def check_win_or_lose
    if @guesses.length == @word.chars.to_a.uniq.length
      return :win
    end
    if @wrong_guesses.length == 7
      return :lose
    end
    return :play
  end

end
