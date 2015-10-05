class Candidate < ActiveRecord::Base
  def slug
    name.gsub(/\s/,"_").downcase
  end
  #belongs_to :popcounter
end
