class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor :word, :guesses, :wrong_guesses 
  # def initialize()
  # end
  
  
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
    throw ArgumentError if letter.nil? || letter.length != 1
    throw ArgumentError if not letter.match(/[A-Za-z]/)
    letter.downcase!
    if @word.include? letter
      if not @guesses.include? letter
        @guesses << letter
        return true
      end
    else
      if not @wrong_guesses.include? letter
        @wrong_guesses << letter
        return true
      end
    end
    false
  end
  
  def word_with_guesses
    res = ''
    @word.each_char{ |c| if not @guesses.include? c then  res << '-' else res << c end}
    res
  end
  
  def check_win_or_lose
    return :lose if @wrong_guesses.length >= 7
    @word.each_char{ |c| if not @guesses.include? c then return :play end }
    :win
  end
end
