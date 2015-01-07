units = ["Ruby Fundamentals"]

ActiveRecord::Base.transaction do
  units.each do |unit|
    unit = Unit.find_or_initialize_by(name: unit)
    unit.save!
  end
end
