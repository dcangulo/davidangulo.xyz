# frozen_string_literal: true

# == Schema Information
#
# Table name: tags
#
#  id          :bigint           not null, primary key
#  description :text             default("")
#  name        :string           default(""), not null
#  slug        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Tag < ApplicationRecord
  include Sluggable
end
