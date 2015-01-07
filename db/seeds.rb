unit_info = JSON.parse(File.read(Rails.root.join("db/units.json")))

ActiveRecord::Base.transaction do
  unit_info["units"].each do |unit_hash|
    unit = Unit.find_or_initialize_by(name: unit_hash["name"])
    unit.description = unit_hash["description"]
    unit.save!

    unit_hash["quizzes"].each do |quiz_hash|
      quiz = Quiz.find_or_initialize_by(unit: unit, name: quiz_hash["name"])
      quiz.save!
    end
  end
end
