class SearchesController < ApplicationController
  def show
    @results = Search.results(params[:query])
  end
end
