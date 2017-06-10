class Users::RegistrationsController < Devise::RegistrationsController
  def build_resoruces(hash=nil)
    hash[:uid] = User.create_unique_string
    super
  end
end
