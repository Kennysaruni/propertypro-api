class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :user_type
end
