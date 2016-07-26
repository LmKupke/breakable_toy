class Api::VotesController < AuthenticateController
  before_action :pre_vote

  def upvote
    if check_time
      # flash[:alert] = "Sorry voting for event has passed"
      flash.now[:alert] = "Sorry voting for event has passed!"
      render json:
        { message: "Sorry voting for event has passed!" }, status: :bad_request
    else
      if @value.vote == 1
        @value.vote -= 1
      else
        @value.vote = 1
      end
      @value.save
      @vote_total = Vote.group(:venueselection_id).sum(:vote)
      render json: @vote_total[@vselect.id]
    end
  end

  def downvote
    if check_time
      render json: { message: "Sorry voting for event has passed!" },
                  status: :bad_request
    else
      if @value.vote == -1
        @value.vote += 1
      else
        @value.vote = -1
      end
      @value.save
      @vote_total = Vote.group(:venueselection_id).sum(:vote)
      render json: @vote_total[@vselect.id]
    end
  end

  def index
    render json: @vselect.votes
  end

  protected

  def pre_vote
    @vselect = Venueselection.find(params[:venueselection_id])
    @value =
      Vote.find_or_initialize_by(venueselection: @vselect, user: current_user)
  end

  def check_time
    @vselect.event.date < Time.zone.now
  end
end
