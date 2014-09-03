module Voteable
  extend ActiveSupport::Concern
  
  included do
    has_many :votes, as: :voteable
  end
  
  def vote_display
    if self.total_votes == 1 || self.total_votes == -1
      return " vote"
    else
      return " votes"
    end
  end

  def total_votes
    up_votes - down_votes
  end

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.where(vote: false).size
  end
end