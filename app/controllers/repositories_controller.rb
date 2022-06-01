class RepositoriesController < ApplicationController
    # ReposPath = "/home/ubuntu/repositories/"
    # Path = File.join(ReposPath,"#{params[:name]}.git")
    def show
        @Repository = Repository.find_by_id(params[:id])
        render json: @Repository
    end

    def new
        @Repository = Repository.new
        render json: @Repository
    end

    def create
        # @article = Article.new(title: params[:title] , text: params[:text])
        @Repository = Repository.new(name: params[:name] , path: params[:path])
        Rugged::Repository.init_at(params[:path], :bare)
        Rugged::Repository.new(params[:path])
        if @Repository.save
          render json: @Repository
        else
          render json: @Repository.errors
        end
      end
end
