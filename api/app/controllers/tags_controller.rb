# frozen_string_literal: true

class TagsController < ApplicationController
  before_action :find_tag, only: %i[show update destroy]

  def index
    tags = Tag.all

    process_collection(tags)
  end

  def create
    tag = Tag.new
    form = TagForm.new(tag)
    data = params[:tag].presence || {}

    if form.validate(data) && form.save
      process_single(form.model)
    else
      process_error(422, form.errors.full_messages)
    end
  end

  def show
    process_single(@tag)
  end

  def update
    form = TagForm.new(@tag)
    data = params[:Tag].presence || {}

    if form.validate(data) && form.save
      process_single(form.model)
    else
      process_error(422, form.errors.full_messages)
    end
  end

  def destroy
    @tag.destroy ? process_single(@tag) : process_error(500)
  end

  private

  def find_tag
    @tag = Tag.find_by(id: params[:id])

    process_error(404, ['Tag not found.']) if @tag.blank?
  end
end
