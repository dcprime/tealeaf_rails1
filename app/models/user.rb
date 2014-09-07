class User < ActiveRecord::Base
  include SlugableDarren
  
  has_many :posts
  has_many :comments
  has_many :votes
  
  has_secure_password validations: false
  
  validates :username, presence: true, uniqueness: true, length: {minimum: 3}
  validates :password, presence: true, on: :create, length: {minimum: 5}
  
  sluggable_column :username
  
  def two_factor_auth?
    !self.phone.blank?
  end
  
  def generate_pin!
    self.update_column(:pin, rand(10 ** 6)) # random 6 digit number
  end
  
  def remove_pin!
    self.update_column(:pin, nil)
  end
  
  def twilio_send
    account_sid = 'AC0825f99bf22576ba3cc963b7fc30e8cd' 
    auth_token = '96746e1f285073628c0c1d4b25d7fd34' 

    # set up a client to talk to the Twilio REST API 
    client = Twilio::REST::Client.new account_sid, auth_token 

    msg = "Please enter this pin to continue login: #{self.pin}"
    client.account.messages.create({
      :from => '+12898099991', 
      :to => '+15194046564', 
      :body => msg,  
    })
  end
  
  def admin?
    self.role == 'admin'
  end
  
  def moderator?
    self.role == 'moderator'
  end

end