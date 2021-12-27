# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id                 :bigint           not null, primary key
#  description        :text             default("")
#  name               :string           default(""), not null
#  slug               :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  parent_category_id :integer
#
class Category < ApplicationRecord
  include Sluggable

  belongs_to :parent_category, class_name: :Category, optional: true

  has_many :sub_categories, class_name: :Category, foreign_key: :parent_category_id
end
