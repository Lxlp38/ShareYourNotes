require 'httparty'

Course.destroy_all
University.destroy_all

uni_url = 'https://dati-ustat.mur.gov.it/api/3/action/datastore_search?resource_id=a332a119-6c4b-44f5-80eb-3aca45a9e8e8'
response = HTTParty.get(uni_url)

if response.code == 200

    datapages = (JSON.parse(response.body)['result']['total'] / 100.0).ceil
    #puts "Total pages: #{datapages}"

    for i in 1..datapages
        response = HTTParty.get(uni_url + "&&offset=#{(i-1)*100}")
        data = JSON.parse(response.body)['result']['records']

        data.each do |uni|
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

    for i in 1..datapages
        response = HTTParty.get(courses_url + "&&offset=#{(i-1)*100}")
        data = JSON.parse(response.body)['result']['records']

        data.each do |course|
            Course.create!(
            name: course['CorsoNOME'],
            year: course['AnnoA'],
            university: University.find_by(code: course['AteneoCOD'])
            )
        #puts "Course #{course['NomeEsteso']} for University with id #{course['AteneoCOD']}"
        end
    end
    puts "Created #{Course.count} Courses"
else
    puts "Error in the Courses request"
end
