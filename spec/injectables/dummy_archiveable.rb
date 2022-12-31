class DummyArchiveable
  attr_reader :published_at

  def initialize(published_at = Time.zone.now)
    @published_at = published_at
  end
end
