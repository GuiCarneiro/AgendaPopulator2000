require 'httparty'
require 'faker'

class AgendaGenerateClassrooms
	def self.generate(school_base_url, school_token, school_auth_token, first_discipline_id, headquarters)
		headers = {
			"Content-Type" => 'application/json',
			"x-api-key" => school_token,
			"Authorization" => "Bearer #{school_auth_token}"
		}

		amount_of_classrooms = 10
		classrooms_generated = []

		(0..amount_of_classrooms).each do |classroom|
			body = {
				classroom: {
					name: Faker::Educator.course_name,
					educational_stage_name: [
						"pre_child","child","fundamental_one","fundamental_two"
					].sample,
					headquarter_id: (headquarters.sample)['id'],
					discipline_ids: [first_discipline_id]
				}				
			}

			response = HTTParty.post("#{school_base_url}/api/import/v2/classrooms", {
			  headers: headers,
			  body: body.to_json
			})

			classrooms_generated << response['data']
		end

		return classrooms_generated
	end
end