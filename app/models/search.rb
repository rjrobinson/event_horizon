class Search < ActiveRecord::Base
  belongs_to :result, polymorphic: true
  attr_accessor :query

  def self.results(query)
    where("searchable @@ plainto_tsquery(?)", query).
      select(:title, :result_id, :result_type).
      preload(:result).
      map(&:result)
  end
end
