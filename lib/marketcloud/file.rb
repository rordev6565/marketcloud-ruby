require_relative 'request'
require 'faraday'
require 'json'
require 'base64'

module Marketcloud
	class File < Request

		def self.plural
			"files"
		end

		# Create a new file in the Marketcloud CDN
		# @param name a human friendly name
		# @param filename a filename
		# @param file file handle from File.open
		# @param description the description of the file
		# @param slug a URL-friendly slug
		# @return a file
		def self.create(name, filename, file, description, slug)
			new_file = perform_request(api_url("files", {}), :post,
						{
							name: name,
							filename: filename,
							file: Base64.encode64(file.read),
							description: description,
							slug: slug
						}, true)

			if new_file
				new new_file['data']
			else
				nil
			end
		end

	end
end
