class SolidTaxi::SolidCache
  def self.present?
    version.present?
  end

  def self.version
    ::SolidCache::VERSION
  rescue NameError
    nil
  end
end
