# frozen_string_literal: true

module ControllerHelpers
  def login(user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in(user)
  end

  def logout
    sign_out(user)
  end
end

RSpec.configure do |config|
  config.include ControllerHelpers, type: :controller
end
