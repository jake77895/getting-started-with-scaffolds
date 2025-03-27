class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all

    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movies/index" })
  end

  def show
    the_id = params.fetch("id")

    matching_movies = Movie.where({ :id => the_id })

    @the_movie = matching_movies.first

    render({ :template => "movies/show" })
  end

  def new
    @the_movie = Movie.new

    # render template: "movies/new"
  end

  def create
    @the_movie = Movie.new
    @the_movie.title = params.fetch("title")
    @the_movie.description = params.fetch("description")
    @the_movie.released = params.fetch("released")

    if @the_movie.valid?
      @the_movie.save
      redirect_to("/movies", { :notice => "Movie was successfully created" })
    else
      flash.now[:alert] = @the_movie.errors.full_messages.to_sentence
      render({ :template => "movies/new"})
    end
  end

  def edit
    @the_movie = Movie.where(id: params.fetch(:id))[0]
    # render template: "movies/edit" 
  end

  def update
    the_id = params.fetch("id")
    @the_movie = Movie.where({ :id => the_id }).first

    @the_movie.title = params.fetch("title")
    @the_movie.description = params.fetch("description")
    @the_movie.released = params.fetch("released")

    if @the_movie.valid?
      @the_movie.save
      redirect_to("/movies/#{@the_movie.id}", { :notice => "Movie updated successfully."} )
    else
      flash.now[:alert] = @the_movie.errors.full_messages.to_sentence
      render({ :template => "movies/edit"})
    end
  end

  def destroy
    the_id = params.fetch("id")
    the_movie = Movie.where({ :id => the_id }).first

    the_movie.destroy

    redirect_to("/movies", { :notice => "Movie deleted successfully."} )
  end
end
