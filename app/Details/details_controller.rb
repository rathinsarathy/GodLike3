require 'rho/rhocontroller'
require 'helpers/browser_helper'

class DetailsController < Rho::RhoController
  include BrowserHelper

  # GET /Details
  def index
    @details = Details.find(:all)
    render :back => '/app'
  end

  # GET /Details/{1}
  def show
    @details = Details.find(@params['id'])
    if @details
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /Details/new
  def new
    @details = Details.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /Details/{1}/edit
  def edit
    @details = Details.find(@params['id'])
    if @details
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /Details/create
  def create
    @details = Details.create(@params['details'])
    response = Rho::Network.get({
          :url => "http://www.godlikebod.com/webservice2_prod1.asmx/SetExerciseComment_new?sessfk=131&execfk=2&setno=1&rep10=1&w1=100&speed=0&heartrate=0&comment=0"
        })

        @msg = "Exercise Details Updated Successfully."
        redirect url_for(:model => :ExerciseDetails,:action => :index, :user_pk =>"3")
end


  # POST /Details/{1}/update
  def update
    @details = Details.find(@params['id'])
    @details.update_attributes(@params['details']) if @details
    redirect :action => :index
  end

  # POST /Details/{1}/delete
  def delete
    @details = Details.find(@params['id'])
    @details.destroy if @details
    redirect :action => :index  
  end
end
