require 'httparty'
require 'faker'

class AgendaGenerateDisciplines
	def self.generate(school_base_url, school_token, school_auth_token, classrooms)
		headers = {
			"Content-Type" => 'application/json',
			"x-api-key" => school_token,
			"Authorization" => "Bearer #{school_auth_token}"
		}

		amount_of_disciplines = 10
		disciplines_generated = []

		(0..amount_of_disciplines).each do |discipline|
			body = {
				discipline: {
					name: Faker::Educator.subject,
					classroom_ids: classrooms.sample(5).map{ |classroom| classroom['id']}
				}				
			}

			response = HTTParty.post("#{school_base_url}/api/import/v2/disciplines", {
			  headers: headers,
			  body: body.to_json
			})

			disciplines_generated << response['data']
		end

		return disciplines_generated
	end
end