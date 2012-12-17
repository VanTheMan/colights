class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  validates_presence_of :email
  validates_presence_of :encrypted_password

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  field :access_token
  field :name, type: String

  # field :authentication_token, :type => String

  def self.find_for_youtube(auth, signed_in_resource=nil)
    binding.pry
    data = auth.info
    credentials = auth.credentials
    user = User.where(:email => data["email"]).first

    unless user
        user = User.create(name: data["name"],
                           email: data["email"],
                           password: Devise.friendly_token[0,20],
                           access_token: credentials["token"]
                )
    end
    user
  end
end
