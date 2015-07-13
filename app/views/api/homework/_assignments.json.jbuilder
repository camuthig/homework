json.merge! @homework.attributes

json.assignments @homework.assignments do |assignment|
  json.extract! assignment, :created_at, :updated_at
  json.url url_for(:controller => 'api/assignment', :action => 'show', :id => assignment.id)
  json.user do
    json.username assignment.user.username
  end
  json.answer do
    if assignment.answers.blank?
      json.null!
    else
      json.extract! assignment.answers.last, :created_at, :answer
    end
  end
end
