class HangpersonGame

  attr_accessor :word, :guesses, :wrong_guesses, :word_with_guesses, :check_win_or_lose
  
  def initialize(word, guesses='', wrong_guesses='')
    @word = word
    @guesses = guesses
    @wrong_guesses = wrong_guesses
    @word_with_guesses = @word.gsub(/\w/,'-')
    @check_win_or_lose = :play
    @wrong_attempts=0
    
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess(character)
    if(character=='' || character=~/\W/ || character==nil)
      
      raise(ArgumentError) 
       
    end
    check_regex = /#{character}/i
    
    if(@guesses !~ check_regex && @wrong_guesses !~ check_regex)
    
      if(@word =~ check_regex)
        @guesses +=  character
        
        @word_with_guesses = @word.gsub(/[^#{@guesses}]/i,'-')
        if @word_with_guesses==@word
           
           @check_win_or_lose = :win
           
        end 
      else
        @wrong_guesses +=  character
        @wrong_attempts +=1
        if @wrong_attempts==7
           
           @check_win_or_lose = :lose
        
        end
      end
    else
      return false
    end
    
  end

end