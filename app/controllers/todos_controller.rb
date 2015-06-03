class TodosController < ApplicationController

  def index
    render json: Todo.all
  end

  def new
    render json: Todo.new
  end

  def show
    begin
      render json: Todo.find(params[:id])

    rescue ActiveRecord::RecordNotFound => error
      render json: { error: error.message}, status: 404

    rescue StandardError => error
      render json: { error: error.message}, status: 422
    end
  end

  def create
    begin
      todolist = Todo.create(body: params.fetch(:body))
      render json: todolist
    rescue ActionController::ParameterMissing => error
      render json: { error: error.message }, status: 422
    end
  end

  def destroy
    if Todo.exists?(params[:id])
      Todo.destroy(params[:id])
      render json: { message: 'removed item from list'}, status: 200
    else
      render json: { error: 'student not found'}, status: 404
    end
  end

  def update
    todo = Todo.find(params[:id])

      todo.body = params[:body]
      todo.completed = params[:body]

      render json: todo
  end
end
