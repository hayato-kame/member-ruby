class ApplicationController < ActionController::Base
  
  private def current_member
    Member.find_by(id: session[:member_id]) if session[:member_id]
  end 
  helper_method :current_member
  
  # クラスを定義
  class LoginRequired < StandardError; end
    
  # クラスを定義
  class Forbidden < StandardError; end
  
  
  if Rails.env.production? || ENV["RESCUE_EXCEPTIONS"]
    rescue_from StandardError, with: :rescue_internal_server_error
    rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_found
    rescue_from ActionController::ParameterMissing, with: :rescure_bad_request
  end 
  
  rescue_from LoginRequired, with: :rescue_login_required
  rescue_from Forbidden, with: :rescue_forbidden
  
  # プライベートメソッドを定義  ユーザがログインしてないと、例外を発生させます
  # MembersController で、使いますbefore_actionに使います　
  private def login_required
    raise LoginRequired unless current_member
  end
  
  # 例外発生に対応する4つのプライベートメソッドを定義する
  private def rescue_bad_request(exception)
    render "errors/bad_request", status: 400, layout: "error", formats: [:html]
  end 
  
  private def rescue_login_required(exception)
    render "errors/login_required", status: 403, layout: "error", formats: [:html]
  end 
  
  private def rescue_forbidden(exception)
    render "errors/forbidden", status: 403, layout: "error", formats: [:html]
  end 
  
  private def rescue_not_found(exception)
    render "errors/not_found", status: 404, layout: "error", formats: [:html]
  end 
  
  private def rescue_internal_server_error(exception)
    render "errors/internal_server_error", status: 500, layout: "error", formats: [:html]
  end
end
