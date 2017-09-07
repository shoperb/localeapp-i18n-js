Rails.application.routes.draw do
  scope :module => LocaleappI18nJs do
    post "localeapp_i18n_js", :to => "localeapp_i18n_js#update"
    get "localeapp_i18n_js", :to => "localeapp_i18n_js#show"
  end
end

