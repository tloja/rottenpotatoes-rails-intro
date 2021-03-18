class Movie < ActiveRecord::Base
#attr_accessible :title, :rating, :description, :release_date
  def self.all_ratings
    # return ['G','PG','PG-13','R']
    %w(G PG PG-13 R)    
  end
  def self.filter_and_sort(selected, sort_key)
    Movie.where(rating:selected).order(sort_key)
    
  end
end
