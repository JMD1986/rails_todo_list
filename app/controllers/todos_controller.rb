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
    if Todo.exists?(params[:id])
      found_todo = Todo.find(params[:id])
      respond_to do |format|
        format.html do
          render 'show.html.erb', locals: { todo: found_todo }
        end
        format.json do
          render json: todo
        end
      end
    end
  end

  def create
    begin
      todo = Todo.create(body: params.fetch(:body),
                        completed: params.fetch(:completed, false))
      redirect_to "/todos"

    rescue ActionController::Paramatermissing => error
      render json: { error: "please specify"},status: 422
    end
  end

  def destroy
    if Todo.exists?(params[:id])
      Todo.destroy(params[:id])
      respond_to  do |format|
        format.html do
          redirect_to "/todos"
        end
        format.json do
          render json: {message: "Todo deleted"}, status: 200
        end
      end
    else
      render json: { message: "todo doesn't exist"}, status: 404
    end
  end

  def update
    todo = Todo.find(params[:id])

    todo.body = params[:body] if params[:body].present?
    todo.completed = params[:completed] if params[:completed].present?

    todo.save

    render json: todo
  end
end

