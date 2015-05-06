require 'rho/rhocontroller'
require 'helpers/browser_helper'

class ExerciseDetailsController < Rho::RhoController
  include BrowserHelper

  # GET /ExerciseDetails
  def index
    response = Rho::Network.get({
          :url => "http://www.godlikebod.com/webservice2_prod1.asmx/GetExerciseInfo?userpk=3"
        })
        doc = REXML::Document.new(response["body"]) 
     doc.elements.each("//ExerciseInfo") do |element|
       @exercisedetails = ExerciseDetails.create(:Exc_Id => element.elements['exc_pk'].text.to_s,
             :Exc_Name => element.elements['exc_name'].text.to_s,
             :User_Id => element.elements['user_fk'].text.to_s,
             :Exc_Date => element.elements['Added_On'].text.to_s,
             :Acc_Id => element.elements['Accessory_Id'].text.to_s
           )
           
             
         end 
    @exercisedetailss = ExerciseDetails.find(:all)
    render :back => '/app'
  end

  # GET /ExerciseDetails/{1}
  def show
   
    @exercisedetails = ExerciseDetails.find(@params['id'])
  
    if @exercisedetails
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
    
  end

  # GET /ExerciseDetails/new
  def new
    @exercisedetails = ExerciseDetails.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /ExerciseDetails/{1}/edit
  def edit
    @exercisedetails = ExerciseDetails.find(@params['id'])
    if @exercisedetails
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /ExerciseDetails/create
  def create
    @exercisedetails = ExerciseDetails.create(@params['exercisedetails'])
    redirect :action => :index
  end

  # POST /ExerciseDetails/{1}/update
  def update
    @exercisedetails = ExerciseDetails.find(@params['id'])
    @exercisedetails.update_attributes(@params['exercisedetails']) if @exercisedetails
    redirect :action => :index
  end

  # POST /ExerciseDetails/{1}/delete
  def delete
    @exercisedetails = ExerciseDetails.find(@params['id'])
    @exercisedetails.destroy if @exercisedetails
    redirect :action => :index  
  end
end
