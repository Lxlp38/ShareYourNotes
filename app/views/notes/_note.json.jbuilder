json.extract! note, :id, :title, :pdf, :owner_id, :course_id, :created_at, :updated_at
json.url note_url(note, format: :json)
