class ChronoChecker::Model
  def initialize(model)
    @model = model
  end

  def has_timestamp_column?
    return false unless @model.table_exists?

    @model.columns.select do |c|
      c.name == timestamp_column && c.type == :datetime
    end.present?
  end

  def compare(order, timestamp)
    operator = order == 'ASC' ? :< : :>
    _timestamp = est_updated(order)

    if _timestamp.public_send(operator, timestamp)
      {
        model: @model.name,
        timestamp: _timestamp
      }
    end
  end

  def est_updated(order)
    record = @model.order("#{timestamp_column} #{order}").first
    return order == 'ASC' ? Time.now : Time.at(0) unless record

    record.send(timestamp_column)
  end

  private

  def timestamp_column
    ChronoChecker::Models::TIMESTAMP_COLUMN
  end
end

require 'chrono_checker/models'