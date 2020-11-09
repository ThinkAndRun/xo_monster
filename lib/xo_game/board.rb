class Board
  require 'matrix'

  # maintains board state as int array where:
  MARKS = {"X": 1, "O": 0, " ": -1}
  # 1  -> player X mark
  # 0  -> player O mark
  # -1 -> blank

  def initialize(settings, steps)
    # initializes board based on what arguments are given
    @m_length = settings.try(:[],'fieldSize').try(:[],'h') || 0
    @n_length = settings.try(:[],'fieldSize').try(:[],'w') || 0
    @k_length = settings.try(:[],'winLineLimit') || 5
    @steps = steps
    @board = nil

    raise 'required' unless @m_length && @n_length && @k_length && steps
    raise 'must match at least 3' if @k_length < 3
    raise 'min dimension of board must be greater than K' if [@m_length, @n_length].min < @k_length
    raise 'dimensions exceeds limit' if @m_length > 999 || @n_length > 999

    @board = Matrix.build(@m_length, @n_length) { -1 }
    steps.each do |step|
      set_move(step)
    end
  end

  def set_move(step)
    return unless can_make_step?(step)
    @board[step['r']-1, step['c']-1] = MARKS[step['m'].to_s.to_sym]
  end

  def can_make_step?(step)
    return false unless step['r'] && step['c']
    return false if step['r'] > @m_length || step['r'] < 0 || step['c'] > @n_length || step['c'] < 0
    return false if @board[step['r']-1, step['c']-1] != -1
    true
  end

  def render
    @board.to_a.flatten.map{|m| MARKS.invert[m].to_s }
  end

  def finished?
    state != -1
  end

  def tie?
    state == 2
  end

  def state
    # checks all iterations of the board to see if it's finished
    catscnt = 0 #keeping track of if all the subboards that are cat's game'd
    subboardcnt = 0
    for i in @k_length.upto(@m_length)
      for j in @k_length.upto(@n_length)
        tempboard = @board.minor(i - @k_length...i, j - @k_length...j)
        ret = check_square(tempboard)
        subboardcnt = subboardcnt + 1
        catscnt = catscnt + 1 if ret == 2 # if any subboard returns a non-cat's game, it's not over
        return ret if ret != 2 && ret != -1 # one of the players won the sub array
      end
    end
    return 2 if catscnt == subboardcnt
    -1 # nobody won and it's not a cat's game
  end

  def check_square(board)
    # returns element causing game over or 2 if cats game
    cats_game = 2
    game_ongoing = -1

    # checks if everything in a row is the same
    check_func = lambda do |arr|
      (arr[0] != -1) && arr.to_a.map{ |el| el == arr[0] }.all?
    end

    # all same marker in a row
    for row in @k_length.times.map{ |idx| board.row(idx).to_a }
      return row[0] if check_func.call(row)
    end

    # all same marker in a col
    for col in @k_length.times.map{ |idx| board.column(idx).to_a }
      return col[0] if check_func.call(col)
    end

    pos_diag = board.each(:diagonal).to_a
    neg_diag = @k_length.times.map{ |idx| board[idx, (@k_length - 1) - idx]}

    # check pos_diag
    if check_func.call(pos_diag)
      return pos_diag[0]
    # check neg_diag
    elsif check_func.call(neg_diag)
      return neg_diag[0]
    end

    # cats game
    return cats_game if board.to_a.flatten.select{|el| el == -1}.count == 0

    # game not over
    game_ongoing
  end


  def raw
    @board
  end

  def winner_mark
    case state
    when 1
      'X'
    when 0
      'O'
    when 2
      'C'
    else
      'N'
    end
  end

  def looser_mark
    case state
    when 1
      'O'
    when 0
      'X'
    when 2
      'C'
    else
      'N'
    end
  end
end