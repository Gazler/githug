module I18n
  def self.exists?(key)
    t!(key)
    true
  rescue MissingTranslationData
    false
  end
end
