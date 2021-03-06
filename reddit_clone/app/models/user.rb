class User < ApplicationRecord
    #spire
    attr_reader :password
    validates :username, :session_token, presence:true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: { minimum:6, allow_nil: true }

    has_many :subs,
        foreign_key: :moderator_id,
        class_name: :Sub


    def self.find_by_credentials(username, password)
        @user = User.find_by(username: username)
        if @user && @user.is_password?(password)
            @user
        else
            nil
        end
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
        self.save
    end

    def is_password?(password)
        Bcrypt::Password.new(password_digest).is_password?(password)
    end

    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.save!
        session[:session_token] = nil

    end

    private

    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end
end
