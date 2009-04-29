require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  include Authorization::AasmRoles

  has_many :lists, :dependent => :destroy
  has_many :testmonials

  validates_presence_of     :login, :unless => :passive?
  validates_length_of       :login, :unless => :passive?, :within => 3..40
  validates_uniqueness_of   :login, :unless => :passive?
  validates_format_of       :login, :unless => :passive?, :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name, :unless => :passive?,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message
  validates_length_of       :name, :unless => :passive?,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :phone, :password, :password_confirmation, :newsletter



  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_in_state :first, :active, :conditions => {:login => login.downcase} # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end
  
  def generate_random_password!
    self.password_confirmation = self.password = String.random
    save
  end
  
  def find_by_email(email)
    User.first(:conditions => { :email => email })
  end
  
  def admin?
    admin
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase.trim : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase.trim : nil)
  end
  
  def to_s
    name
  end
    
  def passive?
    state == 'passive'
  end
  
  def deleted?
    state == 'deleted'
  end
  
  def can_be_created?
    passive? or deleted?
  end
  
  def recently_registered?
    @recently_registered
  end
  
  def self.newsletters
    scoped_by_newsletter(true).all(:conditions => "state NOT LIKE 'deleted'")
  end

  protected
    
    def make_activation_code
        self.deleted_at = nil
        self.activation_code = self.class.make_token
        update_state_to_pending
        @recently_registered = true
    end
    
    def update_state_to_pending
      self.state = 'pending'
    end
end
