require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  has_many :tweets

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation



  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  protected
    
  def self.from_twitter(user_id, username)
      t = Twitter::Base.new(TWITTER_USERNAME, TWITTER_PASSWORD)
      tu = t.user(username)
      f = t.followers()
      f.collect! { |x| x.screen_name }

      if f.include?(username)
          u = new
          pass = ActiveSupport::SecureRandom.base64(6)
          u.name = tu.screen_name
          u.login = username
          u.email = "seb-#{username}@b0b.net"
          puts u.email
          u.password = pass
          u.password_confirmation = pass
          u.twitter_id = user_id
          u.save!
          puts "Following #{username}"
          if not t.friendship_exists?(TWITTER_USERNAME, username)
              t.create_friendship(username)
              t.follow(username)
              # t.d(username, "nerdsinshape.com password: #{pass}")
          end
          return u.reload
      end
      return nil
  end

end
