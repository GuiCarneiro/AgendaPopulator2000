require 'httparty'
require 'faker'

class AgendaGenerateTeams
	def self.generate(school_base_url, school_token, school_auth_token, headquarters)
		headers = {
			"Content-Type" => 'application/json',
			"x-api-key" => school_token,
			"Authorization" => "Bearer #{school_auth_token}"
		}

		amount_of_teams = 20
		teams_generated = []

		(0..amount_of_teams).each do |team|
			body = {
				school_user: {
					status: 'active',
					role: 'manager',
					profile_attributes: {
						name: Faker::Name.name_with_middle,
					},
					classrooms_import: [
						headquarter_id: headquarters.sample['id'],
						educational_stage_name: ["pre_child","child","fundamental_one","fundamental_two"].sample
					],
					username: Faker::Alphanumeric.alphanumeric(number: 12)
				}				
			}

			response = HTTParty.post("#{school_base_url}/api/import/v2/school_users", {
			  headers: headers,
			  body: body.to_json
			})

			teams_generated << response['data']
		end

		return teams_generated
	end
end