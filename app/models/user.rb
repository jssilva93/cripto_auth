class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  has_secure_password
  include Mongoid::Timestamps
  include SimpleEnum::Mongoid

  field :name, type: String
  field :email, type: String
  field :password_digest, :type => String


  has_many :sessions
  validates :email, presence: true, uniqueness: true


  def self.sign_in device_params, session_params={}, oauth_params={}
    if !session_params[:email].blank? && !session_params[:password].blank?
      login_with_email = true
      user = User.where(email: session_params[:email].downcase.strip).first
      user = user.authenticate(session_params[:password]) if user
    else
      return false, "Parámetros inválidos"
    end

    if user
      session =  user.sessions.create!(device_params)
      return true, session
    else
      if login_with_email
        return false,  "Usuario o contraseña inválidos"
      else
        @passenger_data_from_third['token'] = oauth_params[:token]
        @passenger_data_from_third['provider'] = oauth_params[:provider]
        return false, @passenger_data_from_third
      end
    end
  end

end