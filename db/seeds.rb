# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "\n\n\nRicorda! Per caricare tutti i seed usa il comando 'rake db:seed:all'!\n\n\n"

User.destroy_all
Note.destroy_all


more_users=[
    {:username => 'Admin1', :email => 'dellaratta.1994569@studenti.uniroma1.it',
    :password => 'Admin@1', :university_details_id => University.find_by(name: 'Università degli Studi di Catania').id, :role => 'admin', :account_attributes => {}},
    {:username => 'Admin2', :email => 'apa.1713337@studenti.uniroma1.it',
    :password => 'Admin@2', :university_details_id => University.find_by(name: 'Università degli Studi di Catania').id, :role => 'admin', :account_attributes => {}},
    {:username => 'Admin3', :email => 'fortuna.1986101@studenti.uniroma1.it',
    :password => 'Admin@3', :university_details_id => University.find_by(name: 'Università degli Studi di Catania').id, :role => 'admin', :account_attributes => {}},
    {:username => 'Admin4', :email => 'pierro.1990350@studenti.uniroma1.it',
    :password => 'Admin@4', :university_details_id => University.find_by(name: 'Università degli Studi di Catania').id, :role => 'admin', :account_attributes => {}},
    {:username => 'Admin5', :email => 'mariut.1986191@studenti.uniroma1.it',
    :password => 'Admin@5', :university_details_id => University.find_by(name: 'Università degli Studi di Catania').id, :role => 'admin', :account_attributes => {}}
]

more_users.each do |user|
    user = User.create!(user)
    user.add_role user[:role]
end 

p "Created #{User.count} Users"

# Creare una nota con un PDF
user = User.first  # O seleziona l'utente a cui vuoi associare la nota
course = Course.first  # Trova il corso corretto
university = University.find_by(name: 'Università degli Studi di Catania')

file_path = Rails.root.join('db', 'seeds', 'notes', 'Lezione 7_Il bilancio.pdf')

if File.exist?(file_path)
  note = Note.create!(
    title: 'Il bilancio',
    course: course,
    university: university,
    user: user,
    pdf: [File.open(file_path)],  # Carica il PDF
    owner_id: user.id,
    visibility: true
  )
  p "Nota creata con il pdf: #{note.title}"
else
  p "PDF file not found at #{file_path}"
end

p "Created #{Note.count} Notes"


# Course.destroy_all

# more_courses=[
#     {:name => 'Analisi I', :university => University.find_by(code: '05801')},
#     {:name => 'Analisi II', :university => University.find_by(code: '05801')}
# ]

# more_courses.each do |corso|
#     Course.create!(corso)
# end

# p "Created #{Course.count} Courses"
