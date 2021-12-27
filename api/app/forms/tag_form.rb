# frozen_string_literal: true

class TagForm < ApplicationForm
  properties :name, :description, :slug

  validates :name, presence: true
end
