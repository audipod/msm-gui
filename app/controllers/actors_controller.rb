class ActorsController < ApplicationController


  def create
    # params hash looks like this:
    # {"the_title="}

    m = Actor.new
    m.name = params.fetch("the_name")
    m.dob = params.fetch("the_dob")
    m.bio = params.fetch("the_bio")
    m.image = params.fetch("the_image")

    m.save

    redirect_to("/actors")
 

    
  end

  def update
    # Get the ID out of params
    m_id = params.fetch("the_id")

    # Look up the existing record
    matching_records = Actor.where({ :id => m_id })
    the_actor = matching_records.at(0)

    # Overwrite each column with the values from user inputs
    the_actor.name = params.fetch("the_name")
    the_actor.dob = params.fetch("the_dob")
    the_actor.bio= params.fetch("the_bio")
    the_actor.image = params.fetch("the_image")
 

    # Save

    the_actor.save

    # Redirect to the movie details page
    redirect_to("/actors/#{the_actor.id}")
  end

  def destroy
    the_id = params.fetch("an_id")

    matching_records = Actor.where({ :id => the_id })

    the_actor = matching_records.at(0)

    the_actor.destroy

    redirect_to("/actors")
  end

  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end
end
