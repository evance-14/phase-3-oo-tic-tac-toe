class TicTacToe
    #should create a new instance of the game and set the starting
    # state of the board as an array with 9 empty strings set to board
    def initialize
        @board = Array.new(9, " ")
      end

      WIN_COMBINATIONS = [    
    [0,1,2], # Top row
    [3,4,5], # Middle row
    [6,7,8], # Bottom row
    [0,3,6], # First column
    [1,4,7], # Second column
    [2,5,8], # Third column
    [0,4,8], # Diagonal from top left to bottom right
    [2,4,6]  # Diagonal from top right to bottom left
  ]

  def display_board
    #puts statements to print each row ,current state
    #Each board cell is represented by the corresponding value in the @board array.
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    #converts the user_input to an integer using the to_i method, and then 
    #subtracts 1 to get the corresponding index of the @board
    #because the @board array is zero-indexed
    user_input.to_i - 1
 end
    
 def move(index,player_token = "X")
    @board[index] = player_token
 end

 # checks if a position on the @board is taken or not
 def position_taken? (index)
    (@board[index] == "X" || @board[index] == "O")
 end

 #method that checks if a move is valid
 def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end
  #method returns number of turns that have been played based on  @board variable.
  def turn_count
    count = 0
    @board.each do |position|
      if position == "X" || position == "O"
        count += 1
      end
    end
    count
  end

  #uses turn_count method to determine if it is "X"'s or "O"'s turn
  def current_player
    #%modulus operator checks even/odd no turns eventurn-X oddturn-O
    if turn_count % 2 == 0
        "X"
      else
        "O"
      end
  end

  def turn
    puts "Please enter a number between 1-9:"
    #read the user's input using gets.strip and use the input_to_index method to
    # translate the input into an index value
    input = gets.strip

    index = input_to_index(input)

    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      puts "Invalid move, please try again."
      turn
    end
  end

  #use WIN_COMBINATIONS constant to check winning combinations in the @board array
  def won?
    #checks if the values at the corresponding positions 
    #on the @board array match and are not empty,If a matching combination is found
    # the method returns the combination indexes else false
    WIN_COMBINATIONS.each do |win_combination|
      position_1 = @board[win_combination[0]]
      position_2 = @board[win_combination[1]]
      position_3 = @board[win_combination[2]]

      if position_1 == position_2 && position_2 == position_3 && 
        position_taken?(win_combination[0])
        return win_combination
      end
    end

    return false
  end

  # method return true if every element in  board contains either "X" or an "O"
  def full?
    @board.all? { |position| position == "X" || position == "O" }
  end

  #method returns true if the board is full and has not been won,  false otherwise
  def draw?
    full? && !won?
  end

  #that returns true if the board has been won or is full (i.e.is a draw)
  #uses previously defined won? and draw?
  def over?
    won? || draw?
  end

  #method should return the token, "X" or "O", that has won the game
  def winner
    if won?
      winning_combination = won?
      #returns token that appears at  first position of 
      #the winning combination from the @board array.
      @board[winning_combination.first]
    else
      nil
    end
  end
  
  #method use until loop to continue taking turns until the game is over
  #use if statement to determine if the game was won or if it ended in a draw
  # assumes won? method returns  winning player's token ("X" or "O")not their name
  def play
    until over?
      turn
    end
  
    if won?
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end
end