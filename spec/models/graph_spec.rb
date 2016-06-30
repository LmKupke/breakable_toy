require 'rails_helper'

describe Graph, type: :model do
 describe ".new" do
   let!(:user) { create(:user) }
   let(:graph) { Graph.new(user, user) }
   it "should initialize fake Koala" do
     binding.pry
   end
 end
end
