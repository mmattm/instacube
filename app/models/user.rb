class User
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :tags

  field :email, type: String
  field :instagram_username, type: String
  field :password_hash, type: String
  field :password_salt, type: String
  field :pref_nbr, type: Integer

  attr_accessor :password
  before_save :encrypt_password
  before_save :default_values
  
  validates_confirmation_of :password
  validates :password, :presence => true, :confirmation => true, :on => :create
  validates_presence_of :email
  validates_presence_of :instagram_username
  validates_uniqueness_of :email
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def self.find_by_email(email)
    where(:email => email).first
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def default_values
      self.pref_nbr ||= 50 
  end
end
