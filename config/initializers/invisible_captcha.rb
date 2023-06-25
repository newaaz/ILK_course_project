InvisibleCaptcha.setup do |config|
  # config.honeypots           << ['more', 'fake', 'attribute', 'names']
  # config.visual_honeypots    = true
  # config.timestamp_threshold = 2
  config.timestamp_enabled   = !Rails.env.test?
  # config.injectable_styles   = false
  # config.spinner_enabled     = true

  # Leave these unset if you want to use I18n (see below)
  # config.sentence_for_humans     = 'If you are a human, ignore this field'
  config.timestamp_error_message = 'Извините, это было слишком быстро. Пожалуйста, попробуйте еще раз через 5 секунд'
end
