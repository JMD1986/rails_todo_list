class TodosController < ApplicationController

  def index
    all_todos = Todo.all
    respond_to do |format|
      format.html do
        render 'index.html.erb', locals: { todos: all_todos }
      end

      format.json do
        render json: all_todos
      end
    end
  end

  def new
    new_todo = Todo.new
    respond_to do |format|
      format.html do
        render "new.html.erb", locals: { todos: new_todo }
      end

      format.json do
        render json: new_todo
      end
    end
  end

  def show
    begin
      found_todo = Todo.find(params[:id])
        respond_to do |format|
        format.html do
          render "todos/html.erb", locals: { todos: found_todo }
        end
          format
        render json: Todo.find(params[:id])
    end

    rescue ActiveRecord::RecordNotFound => error
      render json: { error: error.message}, status: 404

    rescue StandardError => error
      render json: { error: error.message}, status: 422
    end
  end



  def destroy
    begin
      Todo.destroy(params[:id])
      render json: { message: 'removed item from list'}, status: 200
    rescue ActionController::RecordNotFound => error
      render json: { error: 'todo not found'}, status: 404
    end
  end

  def update
    todo = Todo.find(params[:id])

      todo.body = params[:body]
      todo.completed = params[:body]

      render json: todo
  end
end
