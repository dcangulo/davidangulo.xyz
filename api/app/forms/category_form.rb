# frozen_string_literal: true

class CategoryForm < ApplicationForm
  properties :name, :description, :parent_category_id

  validates :name, presence: true
end
