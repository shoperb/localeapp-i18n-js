module LocaleappI18nJs
  class LocaleappI18nJsController < ActionController::Base

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
        Localeapp.sender.post_missing_translations

        render :json => true
      else
        render :json => false
      end
    end

    protected

    def add_missing_translation(locale, key)
      Localeapp.missing_translations.add locale, key
    end

  end
end


