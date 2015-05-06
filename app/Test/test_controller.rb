require 'rho/rhocontroller'
require 'helpers/browser_helper'

class TestController < Rho::RhoController
  include BrowserHelper

  # GET /Test
  def index
    
    @tests = Test.find(:all)
    render :back => '/app'
  end

  # GET /Test/{1}
  def show
    @test = Test.find(@params['id'])
    if @test
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /Test/new
  def new
    @test = Test.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /Test/{1}/edit
  def edit
    @test = Test.find(@params['id'])
    if @test
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /Test/create
  def create
    @test = Test.create(@params['test'])
    redirect :action => :index
  end

  # POST /Test/{1}/update
  def update
    @test = Test.find(@params['id'])
    @test.update_attributes(@params['test']) if @test
    redirect :action => :index
  end

  # POST /Test/{1}/delete
  def delete
    @test = Test.find(@params['id'])
    @test.destroy if @test
    redirect :action => :index  
  end
end
