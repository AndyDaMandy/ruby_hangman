
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
    attr_accessor :guess, :correct, :blanks
    def initialize
        @words = Words.new
        @word = @words.word_gen
        @solution = @word.split("")
        @correct = []
        @guess = []
        @blanks = blanks_gen(@word, @correct)
        @incorrect = 0
        @winner = false
    end
    def blanks_gen(base_word, right)
        arr = []
        word_arr = base_word.split("")
        x = 0
        until x == word_arr.length do
            if right.length > 0
                word_arr.each do |a|
                    if right.include?(a)
                        arr.push(a)
                    else
                        arr.push("_")
                    end
                    x += 1
                end
            else
                arr.push("_")
                x += 1
            end          
        end
        arr.join(" ")
    end
    def check_guess(check)
        if @solution.include?(check)
            return true
        else
            return false
        end
    end
    def check_win
        check = []
        @solution.each do |a|
            if @correct.include?(a)
                check.push(true)
            else
                check.push(false)
            end
        end
        if check.include?(false) || check.length == 0
            return false
        else
            return true
        end
    end
    def view_word
        puts @word
    end
    def game_play
        until @incorrect == 5
            puts "Guess the word! You can only make 5 mistakes!"
            puts @blanks
            alphabet = "abcdefghijklmnopqrstuvwxyz"
            arr = alphabet.split('')
            input = gets.chomp
                if arr.include?(input.downcase) == false || @guess.include?(input.downcase)
                    until arr.include?(input.downcase) && @guess.include?(input.downcase) == false
                        puts "Error, you need to input a valid letter or something you haven't guessed yet!!"
                        input = gets.chomp
                    end
                end
                puts "you picked: #{input.downcase}!"
                @guess.push(input.downcase)
                puts "Your guesses: #{@guess.join(" - ")}"
                if check_guess(input.downcase) == true
                    @correct.push(input.downcase)
                    if check_win == true
                        puts "You win!"
                        puts "The word was #{@word}!"
                        break
                    end
                else
                    @blanks = blanks_gen(@word, @correct)
                    @incorrect += 1
                    puts "Incorrect! You've made #{@incorrect}/5 incorrect choices! "
                end
                @blanks = blanks_gen(@word, @correct)    
        end
        if check_win == false
            puts "Too bad, you lose!"
            puts "The word was #{@word}!"
        end
    end
end
def play
    @game = Game.new
    @game.view_word
    @game.game_play
end
play