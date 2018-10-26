require 'rails_helper'

RSpec.describe Api::TasksController, type: :controller do
  let(:user) { create(:user) }
  it 'tasks_create' do
    post :create,
    params: { 'user_token' => user.user_token, 'task' => { foo: 'bar' } }
    expect(JSON.parse(response.body)).to eql({
      "error" => "Title can't be blank, Duedate can't be blank, and Priority is not a number"
    })
  end

  let(:task) { create(:task, user_id: user.id, title: 'title') }
  it 'tasks_edit' do
    put :update,
    params: { 'user_token' => user.user_token, 'id' => task.id, 'task' => { 'title' => '', 'description' => 'aaa', 'duedate' => '11/12/2018', 'priority' => '5' }}
    expect(JSON.parse(response.body)).to eql({
      "errors" => "Title can't be blank"
    })
  end

  let(:task2) { create(:task, user_id: user.id, title: 'title') }
  it 'tasks_destroy' do
    delete :destroy,
    params: { 'user_token' => user.user_token, 'batch' => [ task.id, task2.id], 'id' => '0' }
    expect(JSON.parse(response.body)).to eql({"message" => "success"}) 
  end

  let(:task) { create(:task, user_id: user.id, title: 'title') }
  let(:task2) { create(:task, user_id: user.id, title: 'title') }
  it 'tasks_index' do
    get :index,
    params: { 'user_token' => user.user_token, 'order' => 'asc' }
    expect(JSON.parse(response.body)['tasks'].count).to eq(2)
  end

  it 'task_show' do
    get :show,
    params: { 'user_token' => User.first.user_token, 'id' => Task.last.id }
    expect(JSON.parse(response.body)['task']).to eql({
      "description"=>"wasd", 
      "done"=>false, 
      "duedate"=>"2018-12-11T00:00:00.000Z", 
      "id"=>2, 
      "priority"=>2, 
      "title"=>"dsaw", 
      "user_id"=>1
    })
  end
end