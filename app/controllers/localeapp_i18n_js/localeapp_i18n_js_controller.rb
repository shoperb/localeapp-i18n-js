module LocaleappI18nJs
  class LocaleappI18nJsController < ActionController::Base
    skip_before_action :verify_authenticity_token
    
    def show
      render "localeapp_i18n_js/show"
    end

    def update
      if LocaleappI18nJs.localeapp_initialized?
        params[:missing].each do |locale, keys|
          keys.each do |key|
            Localeapp.log "[LocaleappI18nJs] update: locale=#{locale}, key=#{key}"
            add_missing_translation locale, key
          end
        end

        begin
          Localeapp.sender.post_missing_translations
        rescue StandardError => e
          Airbrake.notify(e) if defined?(Airbrake)
        end

        render json: true
      else
        render json: false
      end
    end

    protected

    def add_missing_translation(locale, key)
      Localeapp.missing_translations.add locale, key
    end
  end
end
