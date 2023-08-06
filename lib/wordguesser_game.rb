class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  attr_accessor :word,:guesses,:wrong_guesses

  def word_with_guesses()
    display = ''
    for i in 0..@word.length-1 do
      if @guesses.include?(@word[i])
        display += @word[i]
      else
        display += '-'
      end
    end
    display
  end

  def check_win_or_lose
    @play = wrong_guesses.length
    return :win if word_with_guesses == @word
    return :lose if @play >= 7
    return :play if @play < 7
  end

  def guess(g_word)

    if g_word.nil? or g_word.empty? or !g_word.match?(/[a-zA-Z]/)
      raise ArgumentError
    end

    g_word.downcase!

    if @word.include?(g_word)
      if !@guesses.include?(g_word)
        @guesses += g_word
      else
        return false
      end
    else
      if !@wrong_guesses.include?(g_word)
        @wrong_guesses += g_word
      else
        return false
      end
    end
  end


  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
