Rails.application.routes.draw do
  scope :module => :localeapp_i18n_js do
    post "localeapp_i18n_js", :to => "localeapp_i18n_js#update"
    get "localeapp_i18n_js", :to => "localeapp_i18n_js#show"
  end
end

