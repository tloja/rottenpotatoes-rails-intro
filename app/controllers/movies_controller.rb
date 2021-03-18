class MoviesController < ApplicationController
  @selected_ratings = []
  attr_accessor :selected_ratings
  
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
  def sort_title
    Movie.order(:title)
  end
  def sort_release
    Movie.order(:release_date)
  end
  def index
    @all_ratings = Movie.all_ratings
    @selected_ratings_hash = selected_ratings_hash
    @selected_ratings = selected_ratings
    @sort_key = sort_key
    determine_hilite
    @movies = Movie.filter_and_sort(@selected_ratings, @sort_key)
    

    #selected_ratings_hash = selected_ratings_hash 

    
  end
  
  
  def new
    # default: render 'new' template
  end
  
  def 

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

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
  def selected_all_hash
    Hash[Movie.all_ratings.map {|rating| [rating, "1"] } ]
  end
  def selected_ratings_hash
    params[:ratings] || selected_all_hash
  end
  def selected_ratings
    @selected_ratings_hash&.keys
  end
  def sort_key
    params[:sort] || :id 
    p params[:sort]
  end
  def determine_hilite
    @hilite_headers = {:title => "", :release_date => "", :id => ""}
    @hilite_headers[sort_key] = "bg-warning hilite" 
  end
end
