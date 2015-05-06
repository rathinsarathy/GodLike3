require 'rho/rhocontroller'
require 'helpers/browser_helper'
require "rexml/document"
class UserProfileController < Rho::RhoController
  include BrowserHelper

  # GET /UserProfile
  def index
         response = Rho::Network.get({
            :url => "http://www.godlikebod.com/webservice2_prod1.asmx/ClientDetails?userpk=3"
        })
     doc = REXML::Document.new(response["body"])
     doc.elements.each("//Client") do |element|
       @userprofile = UserProfile.create(:FirstName => element.elements['user_firstname'].text.to_s,
             :LastName => element.elements['user_lastname'].text.to_s,
             :Image => element.elements['user_image'].text.to_s
           )
           
             
         end
   
    @userprofiles = UserProfile.find(:all)
    render :back => '/app'
  end

  # GET /UserProfile/{1}
  def show
    @userprofile = UserProfile.find(@params['id'])
    if @userprofile
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end                
  end

  # GET /UserProfile/new
  def new
    @userprofile = UserProfile.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /UserProfile/{1}/edit
  def edit
    @userprofile = UserProfile.find(@params['id'])
    if @userprofile
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /UserProfile/create
  def create
    @userprofile = UserProfile.create(@params['UserProfile'])
    redirect :action => :index
  end

  # POST /UserProfile/{1}/update
  def update
    @userprofile = UserProfile.find(@params['id'])
    @userprofile.update_attributes(@params['UserProfile']) if @userprofile
    redirect :action => :index
  end

  # POST /UserProfile/{1}/delete
  def delete
    @userprofile = UserProfile.find(@params['id'])
    @userprofile.destroy if @userprofile
    redirect :action => :index  
  end
  
  def upload_image
      @userprofile = UserProfile.find(@params['id'])
      realpath = Rho::RhoApplication::get_blob_path(@userprofile.Image)      
      redirect :action => :index     
  end
  
  end