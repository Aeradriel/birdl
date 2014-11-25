# Devise mailer customization
class DeviseCSSMailer < Devise::Mailer
  def confirmation_instructions(record, token, opts = {})
    content_type 'text/html'
    super
  end

  def reset_password_instructions(record, token, opts = {})
    content_type 'text/html'
    super
  end

  def unlock_instructions(record, token, opts = {})
    content_type 'text/html'
    super
  end
end
