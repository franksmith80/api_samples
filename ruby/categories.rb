require 'net/https'
require 'rexml/document'

# Your account_id number
account_id = 100 
api_key = "0101010101010101010101010101010101"

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
