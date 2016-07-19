class Api::VotesController < ApiController
  before_action :pre_vote

  def upvote
    if @value.vote == 1
      @value.vote -= 1
    else
      @value.vote = 1
    end

    @value.save
    @vote_total = Vote.group(:venueselection_id).sum(:vote)
    render json: @vote_total[@vselect.id]
  end

  def downvote
    if @value.vote == -1
      @value.vote += 1
    else
      @value.vote = -1
    end
    @value.save
    @vote_total = Vote.group(:venueselection_id).sum(:vote)
    render json: @vote_total[@vselect.id]
  end

  def index
    render json: @vselect.votes
  end

  protected

  def pre_vote
    @vselect = Venueselection.find(params[:venueselection_id])
    @value = Vote.find_or_initialize_by(venueselection: @vselect, user: current_user)
  end
end
