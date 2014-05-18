module Subscribem
  class Account < ActiveRecord::Base
    EXCLUDED_SUBDOMAINS = %w(admin) 
    
    belongs_to :owner, :class_name => "Subscribem::User"
    accepts_nested_attributes_for :owner
    
    before_validation do 
      self.subdomain = subdomain.to_s.downcase
    end
    validates_format_of :subdomain, :with => /\A[\w\-]+\Z/i, :message => "is not allowed. Please choose another subdomain."
    validates_exclusion_of :subdomain, :in => EXCLUDED_SUBDOMAINS, :message => "is not allowed. Please choose another subdomain."
    validates :subdomain, :presence => true, :uniqueness => true
  end
end
