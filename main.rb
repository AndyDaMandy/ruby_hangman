
class Words
    attr_reader :WORDS, :word_choice, :word_gen
       WORDS = File.read("google-10000-english-no-swears.txt").split
    
    def word_gen
        @word_choice = ''
        until @word_choice.length > 4 && @word_choice.length < 12
            random = rand(10000)
            @word_choice = WORDS[random]
        end
        @word_choice
    end
end
class Game
    attr_reader :words, :word, :solution
    attr_accessor :guess
    def initialize
        @words = Words.new
        @word = @words.word_gen
        @solution = @word.split("")
        @blanks = blanks_gen(@word, @guess)
        @guess = []
        @incorrect = []
    end
    def blanks_gen(wordle, guess)
        arr = []
        word_length = wordle.split("")
        x = 0
        until x == word_length.length do
            arr.push("_")
            x += 1
        end
        arr.join(" ")
    end
    def view_word
        puts @word
    end
    def game_play
        x = 0
        until x == 5
            puts "Guess the word! You can only make 5 mistakes!"
            alphabet = "abcdefghijklmnopqrstuvwxyz"
            arr = alphabet.split('')
            input = gets.chomp
                if arr.include?(input.downcase) == false || @guess.include?(input.downcase)
                    until arr.include?(input.downcase) && @guess.include?(input.downcase) == false
                        puts "Error, you need to input a valid letter or something you haven't guessed yet!!"
                        input = gets.chomp
                    end
                end
                puts "you picked: #{input}!"
        end
    end
end
def play
    @game = Game.new
    @game.view_word
    @game.game_play
end
play