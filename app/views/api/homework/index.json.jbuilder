json.array!(@homeworks) do |homework|
  json.merge! homework.attributes
end
