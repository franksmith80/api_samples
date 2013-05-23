require 'net/http'
require 'rexml/document'

# Your account_id number
account_id = 36608 
api_key = "524623b4996640585700ab84dc3650ab8aff3c1ed640e66dac0ff1672180eef9"

http = Net::HTTP.new('api.merchantos.com', 443)
http.use_ssl = true

response = http.start do |http|
  request = Net::HTTP::Get.new("/API/Account/#{account_id}/Category.xml")

  # or use username and password instead (not recommended)
  # request.basic_auth username, password
	request.basic_auth(api_key, 'apikey')
	
	# This gets return as response since it's the last thing in the block
	http.request(request)
end

xml = REXML::Document.new(response.body);

xml.elements.each('Categories/Category/name') do |name|
  puts name.text
end
