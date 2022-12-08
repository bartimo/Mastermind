class Mastermind
  attr_accessor :round_number, :valid_guess_entered, :game_end, :turn_end, :clue_history, :guess_history
  attr_reader :secret_code, :possible_numbers, :number_of_rounds, :size_of_code, :blanks_allowed, :duplicates_allowed

  def initialize(possible_numbers, size_of_code, number_of_rounds)
    @possible_numbers = possible_numbers
    @number_of_rounds = number_of_rounds
    @size_of_code = size_of_code
    @round_number = 1
    @blanks_allowed = false
    @duplicates_allowed = false
    @code_entry_error_msg = ''
    @valid_guess_entered = false
    @game_end = false
    @turn_end = false
    @guess_history = []
    @clue_history = []
  end

  def generete_custom_secret_code(code)
    @secret_code = code.to_s.split('')
    p @secret_code
  end

  def generete_random_secret_code
    @secret_code = create_secret_code
    p @secret_code
  end

  def enter_code
    gets.chomp.split('')
  end

  def validate_code(code)
    @code_entry_error_msg = ''
    @code_entry_error_msg += check_code_valid_numbers(code).to_s
    @code_entry_error_msg += check_code_numeric(code).to_s
    @code_entry_error_msg += check_code_length(code).to_s
    @code_entry_error_msg += check_code_unqiue_numbers(code).to_s
    @code_entry_error_msg
  end

  def check_guess(guess)
    results = []
    @secret_code.each_with_index do |num,index|
      if guess[index] == num
        results[index] = 'O'
      elsif @secret_code.include?(guess[index])
        results[index] = 'I'
      else
        results[index] = '.'
      end
    end
    results
  end
=begin
    @secret_code.each do |i|
      if guess[i] == @secret_code[i]
        resuts[i] = 'O'
      elsif @secret_code.include?(guess[i])
        resuts[i] = 'X'
      else
        resuts[i] = '.'
      end
    end
    results
  end
=end

  private

  def create_secret_code
    code_array = []
    for i in 1..@possible_numbers do
      code_array << i.to_s
    end
    code_array.shuffle.slice(0,@size_of_code)
  end

  def check_code_valid_numbers(code)
    if code.min.to_i < 1 || code.max.to_i > @possible_numbers
      @valid_guess_entered = false
      "Out of range numbers entered. \n"
    end
  end

  def check_code_numeric(code)
    unless code.join('').to_i.to_s == code.join('').to_s
      @valid_guess_entered = false
      "Non-numeric charcaters entered. \n"
    end
  end

  def check_code_length(code)
    unless code.length == @size_of_code
      @valid_guess_entered = false
      "Code length must be #{@size_of_code} \n"
    end
  end

  def check_code_unqiue_numbers(code)
    unless code == code.uniq 
      @valid_guess_entered = false
      "Numbers must all be unique.\n"
    end
  end
  # end class Board
end

# Begin Main Program
game = Mastermind.new(6,4,11) # number of colors / size of code / number of rounds
game.generete_random_secret_code

puts ''
puts 'Welcome to Mastermind. The rules are as follows.'
puts '------------------------------------------------'
puts "Allowed numbers: 1 thru #{game.possible_numbers}."
puts "Size of code: #{game.size_of_code}."
puts "Number of rounds: #{game.number_of_rounds}"
puts "Blanks allowed: #{game.blanks_allowed}"
puts "Duplicate numbers: #{game.duplicates_allowed}"
puts ''
# Begin round
until game.game_end
  until game.valid_guess_entered
    game.valid_guess_entered = true # will be set to false if game.validate_code fails
    puts "Round #{game.round_number} of #{game.number_of_rounds}: Enter your guess."
    guess = game.enter_code
    puts "\nYou entered #{guess}\n"
    valid_code_msg = game.validate_code(guess)
    valid_code_msg += "Only enter numbers 1 thru #{game.possible_numbers}. \n\n" unless game.valid_guess_entered
    puts valid_code_msg
  end
  game.valid_guess_entered = false
  game.guess_history.push(guess)
  p game.check_guess(guess)
end
