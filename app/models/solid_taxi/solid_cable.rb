class SolidTaxi::SolidCable
  def self.present?
    version.present?
  end

  def self.version
    ::SolidCable::VERSION
  rescue NameError
    nil
  end
end
