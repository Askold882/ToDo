require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  it 'create_bad_user' do
    post :create,
    params: {user: {'first_name' => '', 'last_name' => '', 'password' => '', 'email' => ''}}
    expect(JSON.parse(response.body)).to eql({
      "error" => "Password can't be blank, Email can't be blank, Email is invalid, First name can't be blank, and Last name can't be blank"
    })
  end

  it 'create_good_user' do
    post :create,
    params: {user: {'first_name' => 'Razor', 'last_name' => 'Vadimovich', 'password' => '555666', 'email' => 'razor12@gmail.com'}, back_url: 'habrahabr.ru'}
    expect(JSON.parse(response.body)).to eql({
      "message" => "user created, now confirm your email"
    })
  end

  let(:user) { create(:user) }
  it 'confirm_email' do
    patch :update,
    params: {'confirm_token' => user.confirm_token}
    expect(response.status).to eql(200) 
    expect(User.first.confirm_token).to eql(nil)
  end
end