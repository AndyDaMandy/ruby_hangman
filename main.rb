
class Words
    attr_reader :WORDS, :word_choice, :word_gen
       WORDS = File.read("google-10000-english-no-swears.txt").split
    
    def word_gen
        @word_choice = ''
        until @word_choice.length > 4 && @word_choice.length < 12
            random = rand(10000)
            @word_choice = WORDS[random]
        end
    end
end
class Game
    def initialize
        @words = Words.new
        @word = @words.word_gen
    end
    def view_word
        puts @word_choice
    end
end
def play
    @game = Game.new
    @game.word
    @game.view_word
end
play