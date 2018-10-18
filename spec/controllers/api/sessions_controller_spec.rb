require 'rails_helper'

RSpec.describe Api::SessionsController, type: :controller do
  it 'login_unconfirmed_user' do
    User.create('email' => 'bibob@gmail.com', 'password' => '555555', 'first_name' => 'Razor', 'last_name' => 'Vadimovich')
    post :create,
    params: {'email' => 'bibob@gmail.com', 'password' => '555555' }
    expect(JSON.parse(response.body)).to eql({
      "error" => "email unconfirmed"
    })
  end
end
