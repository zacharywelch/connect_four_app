module MovesHelper
  def move_for(attributes)
    presenter = MovePresenter.new(attributes, self)
    if block_given?
      yield presenter
    else
      presenter
    end
  end  
end
