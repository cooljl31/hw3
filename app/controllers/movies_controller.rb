class MoviesController < ApplicationController
  include MoviesHelper
  
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
   @movies =  Movie.all
   @all_ratings = Movie.all_ratings
   @sort_type = session[:sort] || params[:sort]
   
   @selected_ratings = @all_ratings
   session[:ratings] = session[:ratings]
   @temp = session[:ratings] || params[:ratings] || {}
   
   session[:sort] = @sort_type
   session[:ratings] = @temp
   
   @movies = Movie.where(rating: session[:rating].keys).order(sort_type)
   
   if params[:sort].nil? or params[:ratings].nil?
     flash.keep
     redirect_to movies_path(sort: session[:sort], ratings: session[:ratings])
   end
   
  # selected_filters = params[:ratings].try(:keys) || @all_ratings
  # # @movies = @movies.where(rating: selected_filters)
   
  # @selected_ratings = selected_filters
   
   
  end
  
  

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  


  
end
