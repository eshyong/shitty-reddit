module VoteableController
  def up(resource)
    vote = resource.votes.find_or_create_by(user_id: user_id)
    resource.with_lock do
      resource.up(vote)
      vote.up
      resource.save!
      vote.save!
    end
  end

  def down(resource)
    vote = resource.votes.find_or_create_by(user_id: user_id)
    resource.with_lock do
      resource.down(vote)
      vote.down
      resource.save!
      vote.save!
    end
  end
end
