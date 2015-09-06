@user_guess = ""
@number_of_guesses = 1
@start_time = 0
@end_time = 0

def play_game
  @start_time = Time.now
  loop do
    puts "What's your guess?"
    @user_guess = gets.chomp.downcase
    if @user_guess.chars == @mystery_sequence
      winning_sequence_play_again_or_quit
    elsif @user_guess.downcase.include?("p")
      play_game_without_initial_prompt
    elsif @user_guess.downcase.include?("q")
      exit
    else
      @number_of_guesses += 1
      incorrect_guess_user_feedback
    end
  end
end

def invalid_guess_try_again
  if @user_guess.length < 4
    puts "Your guess is too short. Please enter a valid sequence."
  elsif @user_guess.length > 4
    puts "Your guess is too long. Please enter a valid sequence."
  else
    play_game
  end
end

def first_game_info_and_play_game
  initial_user_response = gets.chomp
  if initial_user_response.downcase.include?("i")
    puts "Instructions: \nThe objective is to break the secret code in the fewest number of guesses. \nTry to guess the exact colors - (r)ed, (g)reen, (b)lue, and (y)ellow - in the positions of the hidden code sequence."
    play_game
  elsif initial_user_response.downcase.include?("q")
    exit
  else initial_user_response.downcase.include?("p")
    puts "I've generated a beginner sequence with four elements made up of: (r)ed, (g)reen, (b)lue, and (y)ellow. \nUse (q)uit at any time to end the game."
    play_game
  end
end

def play_game_without_initial_prompt
  puts "I have generated a beginner sequence with four elements made up of: (r)ed, (g)reen, (b)lue, and (y)ellow. \nUse (q)uit at any time to end the game."
  play_game
end

def winning_sequence_play_again_or_quit
  @end_time = Time.now
  minutes_played = @end_time.min - @start_time.min
  seconds_played = @start_time.sec + (@end_time.sec - @start_time.sec)
  puts "Congratulations! \nYou guessed the sequence #{@user_guess.upcase} in #{@number_of_guesses} guesses over #{minutes_played} minutes and #{seconds_played} seconds. \nDo you want to (p)lay again or (q)uit?"
  play_again_or_quit = gets.chomp
  if play_again_or_quit.downcase.include?("q")
    exit
  end
end

def incorrect_guess_user_feedback
  positions_correct = 0
  colors_correct = 0
  feedback = []
  @user_guess.chars.each_with_index do |color, index|
    if color == @mystery_sequence[index]
      colors_correct += 1
      positions_correct += 1
      feedback << "I'm sorry, that is incorrect. You got #{colors_correct} colors and #{positions_correct} positions correct. Please guess again."
    end
  end
  puts feedback[feedback.length - 1]
end

puts "Welcome to MASTERMIND. \nWould you like to (p)lay, read the (i)nstructions, or (q)uit?"
first_game_info_and_play_game
