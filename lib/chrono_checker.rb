class ChronoChecker
  def self.list_models
    Models.timestamped_models.map(&:name)
  end

  def self.changed_as_of(datetime)
    Models.changed_as_of(datetime)
  end

  def self.most_recent_change
    Models.newest_or_oldest_change('DESC')
  end

  def self.oldest_change
    Models.newest_or_oldest_change('ASC')
  end
end

require 'chrono_checker/models'