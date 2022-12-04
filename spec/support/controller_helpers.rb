module ControllerHelpers
  def login(user)    
    @request.env['devise.mapping'] = Devise.mappings[:partner]
    sign_in(user)
  end
end
