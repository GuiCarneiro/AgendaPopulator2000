require 'httparty'
require 'faker'

class AgendaGenerateHeadquarters
	def self.generate(school_base_url, school_token, school_auth_token)
		headers = {
			"Content-Type" => 'application/json',
			"x-api-key" => school_token,
			"Authorization" => "Bearer #{school_auth_token}"
		}

		amount_of_headquarters = 3
		headquarters_generated = []

		(0..amount_of_headquarters).each do |headquarter|
			body = {
				headquarter: {
					name: Faker::Educator.primary_school
				}				
			}

			response = HTTParty.post("#{school_base_url}/api/import/v2/headquarters", {
			  headers: headers,
			  body: body.to_json
			})

			headquarters_generated << response['data']
		end

		return headquarters_generated
	end
end