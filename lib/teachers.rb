require 'httparty'
require 'faker'

class AgendaGenerateTeachers
	def self.generate(school_base_url, school_token, school_auth_token, classrooms, disciplines)
		headers = {
			"Content-Type" => 'application/json',
			"x-api-key" => school_token,
			"Authorization" => "Bearer #{school_auth_token}"
		}

		amount_of_teachers = 10
		teachers_generated = []

		(0..amount_of_teachers).each do |teacher|
			body = {
				school_user: {
					status: 'active',
					role: 'teacher',
					profile_attributes: {
						name: Faker::Name.name_with_middle,
					},
					disciplines_by_classrooms_import: {
						classroom_ids: classrooms.sample(5).map{ |classroom| classroom['id']},
						discipline_ids: disciplines.sample(5).map{ |discipline| discipline['id']}
					},
					username: Faker::Alphanumeric.alphanumeric(number: 12)
				}				
			}

			response = HTTParty.post("#{school_base_url}/api/import/v2/school_users", {
			  headers: headers,
			  body: body.to_json
			})

			teachers_generated << response['data']
		end

		return teachers_generated
	end
end