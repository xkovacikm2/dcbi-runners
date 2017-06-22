module ApplicationHelper
  def redirect_unauthorized(message=I18n.t('not_authorized'))
    flash[:danger] = message
    redirect_back root_path
  end

  def redirect_not_found(message=I18n.t('not_found'))
    flash[:danger] = message
    redirect_back root_path
  end
end
