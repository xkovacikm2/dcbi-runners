class Run < ApplicationRecord
  belongs_to :user

  validates_numericality_of :distance, greater_than: 0
  validate :date_is_valid
  validate :duration_is_valid

  #default ordering
  default_scope -> {order date: :desc}

  #validates if date is indeed a date and if it is not from future
  def date_is_valid
    if !date.is_a? Date
      errors.add :date, I18n.t('activerecord.errors.invalid_date_format')
    elsif date.to_date > Date.today
      errors.add :date, I18n.t('activerecord.errors.future_date')
    end
  end

  def duration_is_valid
    if !duration.is_a? Time
      errors.add :duration, I18n.t('activerecord.errors.invalid_time_format')
    end
  end

end
