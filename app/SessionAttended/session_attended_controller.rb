require 'rho/rhocontroller'
require 'helpers/browser_helper'

class SessionAttendedController < Rho::RhoController
  include BrowserHelper

  # GET /SessionAttended
  def index
    response = Rho::Network.get({
            :url => "http://www.godlikebod.com/webservice2_prod1.asmx/GetSessions?userpk=4&sesstype=Attended"
          })
          doc = REXML::Document.new(response["body"]) 
       doc.elements.each("//clientsession") do |element|
         @session_attended = SessionAttended.create(:SessionID => element.elements['sess_pk'].text.to_s,
               :SessionStartDate => element.elements['sess_startDate'].text.to_s,
               :SessionEndDate => element.elements['sess_endDate'].text.to_s,
               :SessionStartTime => element.elements['sess_startTime'].text.to_s,
               :SessionPaid => element.elements['sess_paid'].text.to_s
             )
             
               
           end 
     
    @session_attendeds = SessionAttended.find(:all)
    render :back => '/app'
  end

  # GET /SessionAttended/{1}
  def show
    @session_attended = SessionAttended.find(@params['id'])
    if @session_attended
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /SessionAttended/new
  def new
    @session_attended = SessionAttended.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /SessionAttended/{1}/edit
  def edit
    @session_attended = SessionAttended.find(@params['id'])
    if @session_attended
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /SessionAttended/create
  def create
    @session_attended = SessionAttended.create(@params['session_attended'])
    redirect :action => :index
  end

  # POST /SessionAttended/{1}/update
  def update
    @session_attended = SessionAttended.find(@params['id'])
    @session_attended.update_attributes(@params['session_attended']) if @session_attended
    redirect :action => :index
  end

  # POST /SessionAttended/{1}/delete
  def delete
    @session_attended = SessionAttended.find(@params['id'])
    @session_attended.destroy if @session_attended
    redirect :action => :index  
  end
end
