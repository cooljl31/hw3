module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  
  def sort_movies(sort_type)
    @movies = Movie.order(sort_type)
    instance_variable_set("@#{sort_type}", 'hilite')
  end
end
