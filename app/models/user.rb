class User < ActiveRecord::Base
  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  
  attr_accessor :log_in
   
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  
  validates_uniqueness_of :username, case_sensitive: false
  validates_presence_of   :username
  validates_format_of     :username, :with => /\A[A-Za-z\d]([-\w]{,498}[A-Za-z\d])?\z/i
  
  validates_presence_of   :password_confirmation
  
  validate :validate_username
  
  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end 
  
  
  def log_in=(log_in)
    @log_in = log_in
  end

  def log_in
    @log_in || self.username || self.email
  end
  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if log_in = conditions.delete(:log_in)
      where(conditions.to_hash).where(["username = :value OR email = lower(:value)", { :value => log_in }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end
  
end
