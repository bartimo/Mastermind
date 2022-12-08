class Board
  attr_accessor :round_number
  attr_reader :secret_code

  def initialize(number_of_colors, size_of_code, number_of_rounds)
    @number_of_colors = number_of_colors
    @number_of_rounds = number_of_rounds
    @size_of_code = size_of_code
    @round_number = 1
  end

  def set_custom_secret_code(code)
    @secret_code = code.to_s.split('')
    p @secret_code
  end

  def set_random_secret_code()
    @secret_code = create_secret_code
    p @secret_code
  end

  private
  def create_secret_code
    code_array = []
    for i in 1..@number_of_colors do
      code_array << i.to_s
    end
    code_array = code_array.shuffle.slice(0,@size_of_code)

  end

  # end class Board
end

# Begin Main Program
board = Board.new(6,4,11) # number of colors / size of code / number of rounds
board.set_random_secret_code
