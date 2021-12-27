# frozen_string_literal: true

module Sluggable
  extend ActiveSupport::Concern

  included do
    before_validation :generate_slug
  end

  private

  def generate_slug(suffix = nil)
    return if slug.present?

    slug = [name, suffix].compact_blank.join(' ').parameterize
    suffix = suffix.present? ? suffix + 1 : 1

    return generate_slug(suffix) if self.class.exists?(slug: slug)

    self.slug = slug
  end
end
