class Session
  include Mongoid::Document
  include Mongoid::Timestamps

  field :brand, type: String
  field :model, type: String
  field :os, type: String
  field :os_version, type: String
  field :app_version, type: String
  field :version, type: Float
  field :push_token, type: String
  field :session_token, type: String
  field :imei, type: String
  field :lang, type: String
  field :is_driver_mode_enabled, type: Boolean, default: false


  validates :brand, presence: true
  validates :model, presence: true
  validates :os, presence: true
  validates :os_version, presence: true
  validates :app_version, presence: true

  belongs_to :user, index: true

  before_create :generate_session_token

  index({updated_at: 1})
  index({created_at: 1})
  index({user_id: 1, created_at: 1}, {sparse: true})
  index({session_token: 1})

  def generate_session_token
    self.session_token = loop do
      random_token = SecureRandom.urlsafe_base64(40)
      break random_token unless self.class.where(session_token: random_token).exists?
    end
  end

  def android?
    !!self.os.match(/Android/)
  end

  def ios?
    !!self.os.match(/ios/)
  end

  def checkin params

  end

end #class
