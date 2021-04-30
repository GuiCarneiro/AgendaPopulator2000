require 'httparty'
require 'faker'

class AgendaGenerateStudents
	def self.generate(school_base_url, school_token, school_auth_token, classrooms)
		headers = {
			"Content-Type" => 'application/json',
			"x-api-key" => school_token,
			"Authorization" => "Bearer #{school_auth_token}"
		}

		amount_of_students = 16
		students_generated = []

		(0..amount_of_students).each do |student|
			body = {
				student_profile: {
					name: Faker::Name.name_with_middle,
					classroom_ids: classrooms.sample(5).map{ |classroom| classroom['id']},
					date_of_birth: '01/01/2001',
					period: ["morning","afternoon","integral","night"].sample
				}				
			}

			response = HTTParty.post("#{school_base_url}/api/import/v2/student_profiles", {
			  headers: headers,
			  body: body.to_json
			})

			students_generated << response['data']
		end

		return students_generated
	end
end