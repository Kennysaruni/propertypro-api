class User < ApplicationRecord
    has_secure_password

    validates :username , uniqueness: {case_sensitive: false}
    validates :email, uniqueness: { case_sensitive: false}
    validates :user_type, inclusion: {in: %w(Owner Tenant)}
end
