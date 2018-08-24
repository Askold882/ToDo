require 'rails_helper'

RSpec.describe UsersController , type: :controller do
  
  it 'create_bad_user' do
    post :create,
    params: {'first_name' => '', 'last_name' => '', 'password' => '', 'email' => ''}
    expect(JSON.parse(response.body)).to eql({
      "errors" => "Password can't be blank, Email can't be blank, First name can't be blank, and Last name can't be blank"
    })
  end
  
  it 'create_good_user' do
    post :create,
    params: {'last_name' => 'Djnt', 'first_name' => 'last_name', 'password' => '12341234', 'email' => '228mugivara228@gmail.com'}
    expect(JSON.parse(response.body)).to eql({
      "message" => "user created, now confirm your email"
    })
  end

  it 'confirm_email' do
    User.create('last_name' => 'Djnt', 'first_name' => 'name', 'password' => '12341234', 'email' => '228mugivara228@gmail.com')
    patch :update,
    params: {'confirm_token' => User.first.confirm_token}
    expect(JSON.parse(response.body)).to eql({'message' => 'email confirmed'}) 
    expect(User.first.confirm_token).to eql(nil)
  end
end
