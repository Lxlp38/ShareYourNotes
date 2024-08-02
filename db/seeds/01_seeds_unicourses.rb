require 'httparty'

#Course.destroy_all
#University.destroy_all

uni_url = 'https://dati-ustat.mur.gov.it/api/3/action/datastore_search?resource_id=a332a119-6c4b-44f5-80eb-3aca45a9e8e8'
response = HTTParty.get(uni_url)

if response.code == 200

    datapages = (JSON.parse(response.body)['result']['total'] / 100.0).ceil
    #puts "Total pages: #{datapages}"

    for i in 1..datapages
        response = HTTParty.get(uni_url + "&&offset=#{(i-1)*100}")
        data = JSON.parse(response.body)['result']['records']

        data.each do |uni|
            uni_data = University.find_by(code: uni['COD_Ateneo'])
            if uni_data.nil?
                University.create!(
                    name: uni['NomeEsteso'],
                    op_name: uni['NomeOperativo'],
                    status: uni['status'],
                    uni_type: uni['Tipologia_ateneo_descrizione'],
                    address: uni['Indirizzo'],
                    municipality: uni['COMUNE'],
                    url: uni['URL'],
                    code: uni['COD_Ateneo']
                )
                puts "University #{uni['NomeEsteso']} created with id #{uni['COD_Ateneo']}"
            else
                uni_data.update!(
                    name: uni['NomeEsteso'],
                    op_name: uni['NomeOperativo'],
                    status: uni['status'],
                    uni_type: uni['Tipologia_ateneo_descrizione'],
                    address: uni['Indirizzo'],
                    municipality: uni['COMUNE'],
                    url: uni['URL']
                )
                puts "University #{uni['NomeEsteso']} updated with id #{uni['COD_Ateneo']}"
            end
        end
    end
    puts "Created #{University.count} Universities"
else
    puts "Error in the University request"
end


courses_url = "https://dati-ustat.mur.gov.it/api/3/action/datastore_search?resource_id=c0e63906-7190-4568-892b-0cf399f56071"
response = HTTParty.get(courses_url)

if response.code == 200

    datapages = (JSON.parse(response.body)['result']['total'] / 100.0).ceil
    #puts "Total pages: #{datapages}"


    courses = []

    timenow = Time.now
    courses_universities = {}
    for uni in University.all
        courses_universities[uni.code] = uni.id
    end

    existing_course_names=Set.new(Course.pluck(:name))
    #University.find_by(code: course['AteneoCOD']).id,

    for i in 1..datapages
        response = HTTParty.get(courses_url + "&&offset=#{(i-1)*100}")
        data = JSON.parse(response.body)['result']['records']


        data.each do |course|
            course_name=course['CorsoNOME']
            next if existing_course_names.include?(course_name)

            existing_course_names.add(course_name)

            courses << {
                id: course['_id'],
                name: course_name,
                year: course['AnnoA'],
                university_id: courses_universities[course['AteneoCOD'].to_s],
                created_at: timenow,
                updated_at: timenow
            }
        end
    end
    Course.upsert_all(courses, unique_by: :id)
    puts "Created #{Course.count} Courses"
end
