class ChronoChecker::Models
  TIMESTAMP_COLUMN = 'updated_at'.freeze

  def self.list
    _models = ActiveRecord::Base.descendants
    if _models.empty?
      Rails.application.eager_load!
      ActiveRecord::Base.descendants
    else
      _models
    end
  end

  def self.timestamped_models
    list.select do |m|
      ChronoChecker::Model.new(m).has_timestamp_column?
    end
  end

  def self.newest_or_oldest_change(order)
    res = {
      model: nil,
      timestamp: order == 'ASC' ? Time.now : Time.at(0)
    }

    timestamped_models.each do |m|
      _model = ChronoChecker::Model.new(m)
      res = _model.compare(order, res[:timestamp]) || res
    end

    res
  end

  def self.changed_as_of(datetime)
    timestamped_models.select do |m|
      m.where("#{TIMESTAMP_COLUMN} > ?", datetime).present?
    end.map(&:name)
  end
end

require 'chrono_checker/model'