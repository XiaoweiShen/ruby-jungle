require 'rails_helper'

 RSpec.describe "Users", type: :request do
  it "should include data and pass validation" do
    @user = User.new
   expect(@user.firstname).to be_nil
   expect(@user.lastname).to be_nil
   expect(@user.email).to be_nil
   expect(@user.password).to be_nil
  end
end
RSpec.describe User, type: :model do
  if User.find_by_email('t@t.com') 
    User.find_by_email('t@t.com').destory
 end
  describe 'Validations' do
    it "should false on sign up when lastname is nil" do
      @user = User.new
       @user.firstname = 'test'
       @user.lastname = ''
       @user.email='t@t.com'
       @user.password='123'
       @user.password_confirmation='123'
      expect(@user.save).to be_falsey
    end
    it "should false on sign up when firstname is nil" do
       @user = User.new
       @user.firstname = ''
       @user.lastname = 'test'
       @user.email='t@t.com'
       @user.password='123'
       @user.password_confirmation='123'
      expect(@user.save).to be_falsey
    end
    it "should false on sign up when pass mismatch" do
      @user = User.new
      @user.firstname = 'test'
      @user.lastname = 'test'
      @user.email='t@t.com'
      @user.password='123'
      @user.password_confirmation='321'
     expect(@user.save).to be_falsey
   end
   it "should success when all data" do
    @user = User.new
    @user.firstname = 'test'
    @user.lastname = 'test'
    @user.email='t@t.com'
    @user.password='123'
    @user.password_confirmation='123'
   expect(@user.save).to be_truthy
 end
 it "should exist the user test" do
  @user = User.new
  @user.firstname = 'test'
  @user.lastname = 'test'
  @user.email='t@t.com'
  @user.password='123'
  @user.password_confirmation='123'
  @user.save!
  expect(User.find_by_email('t@t.com')).to be_truthy
end
it "should fail when sign up with same email" do
  if User.all.length>0
    User.destroy_all
  end 
  User.create!({firstname:'test',lastname:'test',email:'1',password:'123',password_confirmation:'123'})
  user=User.new
  user.firstname = 'test3'
  user.lastname = 'test3'
  user.email='1'
  user.password='123'
  user.password_confirmation='123'
  expect(user.save).to be_falsey 
  expect(user.valid?).to be_falsey
  expect(user.errors.messages[:email].to_s.include?('has already been taken')).to be_truthy
end

end
  describe '.authenticate_with_credentials' do
    if User.all.length>0
      User.destroy_all
    end
    it "should pass with email and pass" do
    user = User.create!({firstname:'test',lastname:'test',email:'1',password:'123',password_confirmation:'123'})
    ses = User.authenticate_with_credentials(user.email,user.password)  
    expect(ses.email).presence 
   
  end
  it "should pass with email and pass" do
    p User.all.length
    user = User.create!({firstname:'test',lastname:'test',email:'a1@t.com',password:'123',password_confirmation:'123'})
    expect(User.authenticate_with_credentials("   A1@t.com",user.password).email).presence 
    
    
   end
  end
end



