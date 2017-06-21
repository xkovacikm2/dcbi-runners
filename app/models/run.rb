class Run < ApplicationRecord
  belongs_to :user

  validates_numericality_of :duration, greater_than: 0
  validates_numericality_of :distance, greater_than: 0
  validate :date_is_valid

  #validates if date is indeed a date and if it is not from future
  def date_is_valid
    if !date.is_a? Date
      errors.add :date, I18n.t('activerecord.errors.invalid_date_format')
    elsif date.to_date > Date.today
      errors.add :date, I18n.t('activerecord.errors.future_date')
    end
  end

end
