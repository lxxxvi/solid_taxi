class SolidTaxi::Rails
  def self.present?
    version.present?
  end

  def self.version
    ::Rails.version
  rescue NameError
    nil
  end
end
