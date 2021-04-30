require 'httparty'
require 'faker'

class AgendaGenerateResponsibles
	def self.generate(school_base_url, school_token, school_auth_token, students)
		headers = {
			"Content-Type" => 'application/json',
			"x-api-key" => school_token,
			"Authorization" => "Bearer #{school_auth_token}"
		}

		amount_of_responsibles = 16
		responsibles_generated = []

		(0..amount_of_responsibles).each do |responsible|
			body = {
				responsible_profile: {
					name: Faker::Name.name_with_middle,
					student_profile_ids: students.sample(5).map{ |student| student['id']},
					date_of_birth: '01/01/2001',
					kinship: ["mother","father","grandmother","grandfather","aunt","uncle",
						"nanny","stepfather","stepmother","cousin","brother","sister","other"].sample,
					username: Faker::Alphanumeric.alphanumeric(number: 12)
				}				
			}

			response = HTTParty.post("#{school_base_url}/api/import/v2/responsible_profiles", {
			  headers: headers,
			  body: body.to_json
			})

			responsibles_generated << response['data']
		end

		return responsibles_generated
	end
end