# Helpers for traductions
module I18nHelper
  def flag(locale)
    flags = { fr: 'France.ico', en: 'United-States.ico', es: 'Spain.ico' }
    flags[locale]
  end

  def browser_language
    http_language = request.env['HTTP_ACCEPT_LANGUAGE']
    http_language.scan(/^[a-z]{2}/).first if http_language
  end

  def current_user_locale
    if current_user && current_user.locale
      return current_user.locale
    end
    nil
  end
end
