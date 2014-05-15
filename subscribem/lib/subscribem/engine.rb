require "warden"
module Subscribem
  class Engine < ::Rails::Engine
    isolate_namespace Subscribem

  # The rules for serializing into and from the session are very simple. 
  # We only want to store the bare minimum amount of data in the session, 
  # => since it is capped at about 4kb of data. 
  # Storing an entire User object in there is not good, 
  # => as that will take up the entire session! 
  # The minimal amount of information we can store is the user’s ID, 
  # => and so that’s how we’ve defined serialize_into_session. 
  # For serialize_from_session, we query the Subscribem::User table
  # =>  to find the user with that ID that was stored in the session by serialize_into_session.
    initializer "subscribem.middleware.warden" do 
      Rails.application.config.middleware.use Warden::Manager do |manager|
        manager.serialize_into_session do |user|
          user.id
        end
        manager.serialize_from_session do |id|
          Subscribem::User.find(id)
        end
      end
    end

    config.generators do |g|
      g.test_framework :rspec, :view_specs => false
    end
  end
end
