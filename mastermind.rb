class Mastermind
  def initialize
    puts "|-------------- Welcome to MASTERMIND! --------------|\n"
    puts "|Rules:                                              |"
    puts "|Codemaker generates a 4-digit secret code (1-6).    |"
    puts "|You get 12 tries to guess the secret code.          |"
    puts "|----------------------------------------------------|"
    @game = Game.new
    play_codebreaker
  end

  def play_codebreaker
    puts "|Enter a 4-digit code (1-6).                         |"
    @guess = gets.chomp
    while @guess.length != 4 || !(@guess =~ /[1-6]{4}/)
      puts "|Invalid guess. Example: 1234.                       |"
      @guess = gets.chomp
    end
    @guess = @guess.split('')
    if Game.check(@guess)
      play_codebreaker
    end
  end
end

  class Game
    def initialize
      @@guesses_remaining = 12
      $secret_code = []
      4.times do
        $secret_code << rand(1..6).to_s
      end
    end

    def self.check(guess)
      if (@@guesses_remaining > 1)
        @@temp = $secret_code.dup
        @correct = 0
        @position = 0
        (0..3).each do |i|
          if guess[i] == @@temp[i]
            @correct += 1
            @@temp[i] = 'x'
            guess[i] = 'y'
          end
        end

        (0..3).each do |j|
          if guess.include?(@@temp[j])
            @position += 1
            idx = guess.index(@@temp[j])
            guess[idx] = 'y'
          end
        end

        if @correct == 4
          winner
        else
          @@guesses_remaining -= 1
          puts "|Correct Number, Correct Position: #{@correct}                 |"
          puts "|Correct Number, Out of Position: #{@position}                  |"
          if @@guesses_remaining > 9
            puts "|Guesses Remaining: #{@@guesses_remaining}                               |"
          else
            puts "|Guesses Remaining: #{@@guesses_remaining}                                |"
          end
          puts "|----------------------------------------------------|"
          return true
        end
      end
    else
      loser
    end

    def self.play_again
      puts "|Play again? (y/n)                                   |"
      play = gets.chomp.downcase
      if play == 'y' || play == 'yes'
        Mastermind.new
        exit
      else
        puts "|GG, have a nice day!                                |"
        exit
      end
    end

    def self.winner
      puts "|--------------------- YOU WIN! ---------------------|"
      play_again
    end

    def self.loser
      puts "|The code was: #{$secret_code.join('')}                                  |"
      puts "|--------------------- YOU LOSE ---------------------|"
      play_again
    end
  end


Mastermind.new
