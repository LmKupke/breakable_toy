require 'rails_helper'

RSpec.describe User, type: :model do

  it { should have_valid(:name).when("Bran Stark", "Hodor HoldtheDoor") }
  it { should_not have_valid(:name).when(nil, '') }


  it { should have_valid(:email).when("warthogbran@got.com", "hodor@gmail.com") }
  it { should_not have_valid(:email).when(nil, '', 'warthog', 'warthog@com', 'wartha.com') }

  it 'has a matching password confirmation for the password' do
    user = User.new
    user.password = 'password'
    user.password_confirmation = 'anotherpassword'

    expect(user).to_not be_valid
    expect(user.errors[:password_confirmation]).to_not be_blank
  end

  describe '.name' do
    it 'returns the name of the user' do
      user = create(:user, name: "Arya Stark")
      name = user.name
      expect(name).to eq("Arya Stark")
    end
  end


  describe '.email' do
    it 'returns the email of the user' do
      user = create(:user, email: "valarmorghulis@gmail.com")
  	  result = user.email
  	  expect(result).to eq("valarmorghulis@gmail.com")
    end
  end

  describe '.password' do
    it 'returns the password of the user' do
      user = create(:user, password: "manyfacedgod", password_confirmation: "manyfacedgod")
  	  result = user.password
  	  expect(result).to eq("manyfacedgod")
    end
  end

  describe'.photo' do
    it 'returns the profpic of the user' do
      user = create(:user)
  	  result = user.photo
  	  expect(result).to eq("photo.png")
    end
  end

  describe '.role' do
    context 'user is a member' do
      it 'returns member' do
        user = create(:user)
    	  result = user.role
    	  expect(result).to eq("member")
      end
    end

    context 'user is a admin' do
      it 'returns admin' do
        user = create(:user, role:"admin")
    	  result = user.role
    	  expect(result).to eq("admin")
      end
    end
  end

  # describe "#admin?" do
  #   context 'when user is a member' do
  #     it 'returns false' do
  #       user = create(:user)
  #       expect(user.admin?).to eq(false)
  #     end
  #   end
  #
  #   context "when user is an admin" do
  #     it 'returns true' do
  #       user = create(:user, role: "admin")
  #       expect(user.admin?).to eq(true)
  #     end
  #   end
  # end
end
