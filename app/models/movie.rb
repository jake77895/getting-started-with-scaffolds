# == Schema Information
#
# Table name: movies
#
#  id          :bigint           not null, primary key
#  description :text
#  released    :boolean
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# app/models/movie.rb

class Movie < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
end
