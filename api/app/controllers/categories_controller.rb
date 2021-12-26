# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :find_category, only: %i[show update destroy]

  def index
    categories = Category.all

    process_collection(categories)
  end

  def create
    category = Category.new
    form = CategoryForm.new(category)
    data = params[:category].presence || {}

    if form.validate(data) && form.save
      process_single(form.model)
    else
      process_error(422, form.errors.full_messages)
    end
  end

  def show
    process_single(@category)
  end

  def update
    form = CategoryForm.new(@category)
    data = params[:category].presence || {}

    if form.validate(data) && form.save
      process_single(form.model)
    else
      process_error(422, form.errors.full_messages)
    end
  end

  def destroy
    @category.destroy ? process_single(@category) : process_error(500)
  end

  private

  def find_category
    @category = Category.find_by(id: params[:id])

    process_error(404, ['Category not found.']) if @category.blank?
  end
end
