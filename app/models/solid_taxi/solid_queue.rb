class SolidTaxi::SolidQueue
  def self.present?
    version.present?
  end

  def self.supports_batches?
    gte_v1_7?
  end

  def self.gte_v1_7?
    gem_version >= "1.7"
  end

  def self.gem_version
    Gem::Version.new(version)
  end

  def self.version
    ::SolidQueue::VERSION
  rescue NameError
    nil
  end
end
