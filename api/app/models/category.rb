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
  belongs_to :parent_category, class_name: :Category, optional: true

  has_many :sub_categories, class_name: :Category, foreign_key: :parent_category_id

  before_create :generate_slug

  private

  def generate_slug(suffix = nil)
    return if slug.present?

    slug = [name, suffix].compact_blank.join(' ').parameterize

    if Category.exists?(slug: slug)
      suffix = suffix.present? ? suffix + 1 : 1

      generate_slug(suffix)
    else
      self.slug = slug
    end
  end
end
