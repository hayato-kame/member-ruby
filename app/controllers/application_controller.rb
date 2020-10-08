class ApplicationController < ActionController::Base
  
  private def current_member
    Member.find_by(id: session[:member_id]) if session[:member_id]
  end 
  helper_method :current_member
  
  # クラスを定義
  class LoginRequired < StandardError; end
    
  # クラスを定義
  class Forbidden < StandardError; end
    
  # プライベートメソッドを定義  ユーザがログインしてないと、例外を発生させます
  # MembersController で、使いますbefore_actionに使います　
  private def login_required
    raise LoginRequired unless current_member
  end
  
end
