require 'spec_helper'

module Subscribem
  describe Account do
    it "can be created with an owner" do 
      params = {
        :name => "Test Account",
        :subdomain => "test",
        :owner_attributes => {
          :email => "user@example.com",
          :password => "password",
          :password_confirmation => "password"
        }
      }

      account = Subscribem::Account.create_with_owner(params)
      expect(account).to be_persisted
      expect(account.users.first).to eq(account.owner)
    end

    it "cannot create an account without a subdomain" do 
      account = Subscribem::Account.create_with_owner
      expect(account).to_not be_valid
      expect(account.users).to be_empty
    end
  end
end
