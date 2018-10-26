require 'rails_helper'

RSpec.describe UsersController , type: :controller do
  
  it 'create_bad_user' do
    post :create,
    params: {user: {'first_name' => '', 'last_name' => '', 'password' => '', 'email' => ''}}
    expect(JSON.parse(response.body)).to eql({
      "error" => "Password can't be blank, Email can't be blank, Email is invalid, First name can't be blank, and Last name can't be blank"
    })
  end
  
  it 'create_good_user' do
    post :create,
    params: {user: {'last_name' => 'SpanchBob', 'first_name' => 'last_name', 'password' => '12341234', 'email' => 'sponge@gmail.com'}}
    expect(JSON.parse(response.body)).to eql({
      "message" => "user created, now confirm your email"
    })
  end
  
  let(:user) { create(:user) }
  it 'confirm_email' do
    patch :update,
    params: {'confirm_token' => user.confirm_token}
    expect(response.status).to eql(302) 
    expect(User.first.confirm_token).to eql(nil)
  end
end
