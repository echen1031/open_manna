class Verse < ActiveRecord::Base
  def self.random
    Verse.offset(rand(Verse.count)).first
  end
end
