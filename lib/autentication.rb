require 'httparty'

class AgendaAutentication
	def self.auth(school_username, school_password, school_base_url, school_token)
		body = {
			email: school_username,
	  	password: school_password
		}
		headers = {
			"Content-Type" => 'application/json',
			"x-api-key" => school_token
		}

		response = HTTParty.post("#{school_base_url}/api/import/v2/sessions", {
		  headers: headers,
		  body: body.to_json
		})

		if response.code == 200
			return response.parsed_response['auth_token']
		else
			puts response.parsed_response
			raise StandardError.new "Falha na autenticação"
		end
	end
end