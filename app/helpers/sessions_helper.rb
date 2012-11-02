module SessionsHelper
	def signed_in?
    !current_user.nil?
  end

  def author_signed_in?
    user_role_id == Role::AUTHOR
  end
  
  private
	def user_role_id
    current_user.role.id
  end
end
