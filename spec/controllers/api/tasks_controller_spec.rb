require 'rails_helper'

RSpec.describe Api::TasksController, type: :controller do
  it 'tasks_create' do
    User.create('email' => 'bibob@gmail.com', 'password' => '555555', 'first_name' => 'Razor', 'last_name' => 'Vadimovich')
    post :create,
    params: { 'user_token' => User.first.user_token }
    expect(JSON.parse(response.body)).to eql({
      "error" => "Title can't be blank, Duedate can't be blank, and Priority is not a number"
    })
  end
  
  it 'tasks_edit' do
    User.create('email' => 'bibob@gmail.com', 'password' => '555555', 'first_name' => 'Razor', 'last_name' => 'Vadimovich')
    User.first.tasks.create('title' => 'wasd', 'description' => 'wasd', 'duedate' => '11/12/2018', 'priority' => '7')
    put :update,
    params: { 'user_token' => User.first.user_token, 'id' => Task.first.id, 'title' => '', 'description' => 'aaa', 'duedate' => '11/12/2018', 'priority' => '5' }
    expect(JSON.parse(response.body)).to eql({
      "errors" => "Title can't be blank"
    })
  end

  it 'tasks_destroy' do
    User.create('email' => 'bibob@gmail.com', 'password' => '555555', 'first_name' => 'Razor', 'last_name' => 'Vadimovich')
    User.first.tasks.create('title' => 'wasd', 'description' => 'wasd', 'duedate' => '11/12/2018', 'priority' => '7')
    User.first.tasks.create('title' => 'dsaw', 'description' => 'wasd', 'duedate' => '11/12/2018', 'priority' => '1')
    delete :destroy,
    params: { 'user_token' => User.first.user_token, 'batch' => [ Task.first.id, Task.last.id], 'id' => '0' }
    expect(JSON.parse(response.body)).to eql({"message" => "success"}) 
  end

  it 'tasks_index' do
    User.create('email' => 'bibob@gmail.com', 'password' => '555555', 'first_name' => 'Razor', 'last_name' => 'Vadimovich')
    User.first.tasks.create('title' => 'wasd', 'description' => 'wasd', 'duedate' => '11/12/2018', 'priority' => '1')
    User.first.tasks.create('title' => 'dsaw', 'description' => 'wasd', 'duedate' => '11/12/2018', 'priority' => '2')
    get :index,
    params: { 'user_token' => User.first.user_token, 'order' => 'asc' }
    expect(JSON.parse(response.body)['tasks'].count).to eq(2)
  end 

  it 'tasks_show' do
    User.create('email' => 'bibob@gmail.com', 'password' => '555555', 'first_name' => 'Razor', 'last_name' => 'Vadimovich')
    User.first.tasks.create('title' => 'wasd', 'description' => 'wasd', 'duedate' => '11/12/2018', 'priority' => '1')
    User.first.tasks.create('title' => 'dsaw', 'description' => 'wasd', 'duedate' => '11/12/2018', 'priority' => '2')
    get :show,
    params: { 'user_token' => User.first.user_token, 'id' => [ Task.first.id, Task.last.id] }
    expect(JSON.parse(response.body)).to eql({
      "tasks" => nil
    })
  end
end