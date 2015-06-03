class TodosController < ApplicationController
  def index
    @todos = Todo.all
    user_data = @todos.each do |result|
      "#{result.body}, #{result.completed}"
    end
      render json: user_data, status: 200
    end
end
