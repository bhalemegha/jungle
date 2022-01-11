require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
      it "Password and Confirmed password fields should match" do   
        @user = User.new(name: "Sam", last_name: "Brad", email: "s.brad@gmail.com", password: "12345", password_confirmation: "1234")
        @user.validate
        expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
      end   
      it "Email should be unique(case insensitive)" do   
        @user = User.new(name: "Sam", last_name: "Brad", email: "SAM.brad@gmail.com", password: "12345", password_confirmation: "12345")
        @user.save
        @user2 = User.new(name: "Sam", last_name: "Brad", email: "SAM.brad@gmail.com", password: "12345", password_confirmation: "12345")
        @user2.validate
        expect(@user2.errors[:email]).to include("has already been taken")
      end 
      it "validate if name is empty" do
        @user = User.new(last_name: "Brad", email: "sam.brad@gmail.com", password: "12345", password_confirmation: "12345")
        @user.validate
        expect(@user.errors[:name]).to include("can\'t be blank")
      end
      it "validate if last_name is empty" do   
        @user = User.new(name: "Brad", email: "sam.brad@gmail.com", password: "12345", password_confirmation: "12345")
        @user.validate
        expect(@user.errors[:last_name]).to include("can\'t be blank")
      end
      it "validate if email is empty" do   
        @user = User.new(name: "Brad", last_name:"Brad", password: "12345", password_confirmation: "12345")
        @user.validate
        expect(@user.errors[:email]).to include("can\'t be blank")
      end 
      it "Password length must be 5 or more" do  
        @user = User.new(name: "Sam", last_name: "Brad", email: "sam.brad@gmail.com", password: "123", password_confirmation: "123")
        @user.validate
        expect(@user.errors[:password]).to include("is too short (minimum is 5 characters)")
      end  
      
      it "Should create user if all validations pass" do  
        @user = User.new(name: "Sam", last_name: "Brad", email: "sam11.brad@gmail.com", password: "12345", password_confirmation: "12345")
        @user.validate
        expect(@user.errors).to be_empty
      end 
    end

    describe '.authenticate_with_credentials' do
      it "should not authenticate user" do
        @user = User.new(name: "Sam", last_name: "Brad", email: "sam.brad@gmail.com", password: "12345", password_confirmation: "12345")
        @user.save!
        expect(User.authenticate_with_credentials("sam.brad@gmail.com", "23456")).to_not be_present
      end 

      it "should not authenticate user with wrong email" do
        @user = User.new(name: "Sam", last_name: "Brad", email: "sam.brad@gmaIl.com", password: "12345", password_confirmation: "12345")
        @user.save!
        expect(User.authenticate_with_credentials("sa.brad@gmail.com", "12345")).to_not be_present
      end 

      it "should authenticate user" do
        @user = User.new(name: "Sam", last_name: "Brad", email: "sam.brad@gmail.com", password: "12345", password_confirmation: "12345")
        @user.save!
        expect(User.authenticate_with_credentials("sam.brad@gmail.com", "12345")).to be_present
      end

      it "should authenticate user" do
        @user = User.new(name: "Sam", last_name: "Brad", email: "Sam.brad@gmaIl.com", password: "12345", password_confirmation: "12345")
        @user.save!
        expect(User.authenticate_with_credentials("sam.brad@gmail.com", "12345")).to be_present
      end 
    end

end