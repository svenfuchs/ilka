require 'aws-sdk-s3'
require 'base64'
require 'cgi'
require 'json'

NUMBERS = ENV['NUMBERS'] || []

DEFAULTS = {
  name: 'Ilka',
  location: 'Schnackenburg',
  occupation: 'ferry'
}

BUCKET = 'faehrt-die-ilka.schnackenburg.de'
KEY = 'index.json'
REGION = 'eu-west-1'

def s3
  Aws::S3::Client.new(region: REGION)
end

def lambda_handler(event:, context:)
  msg = decode(event['body'] || '')
  # return unless NUMBERS.include?(msg[:from])
  data = DEFAULTS.merge(parse(msg[:body]))
  store(data)
end

def store(data)
  s3.put_object(
    bucket: BUCKET,
    key: KEY,
    body: JSON.dump(data),
    content_type: 'application/json'
  )
end

def parse(str)
  {
    service: service(str)
  }
end

def service(str)
  str = str.to_s.downcase.gsub(/\P{L}/u, '')
  return false if str =~ /nicht/
  str =~ /ja|yes|ok|fährt|faehrt|allesklar/ ? true : false
end

def decode(body)
  body = Base64.decode64(body) if body =~ /=$/
  pairs = body.split('&')
  pairs = pairs.map { |pair| pair.split('=') }
  pairs = pairs.reject { |pair| pair.size < 2 }
  pairs = pairs.map { |key, value| [underscore(key).to_sym, CGI.unescape(value)] }
  pairs.to_h
end

def underscore(string)
  string.gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
  gsub(/([a-z\d])([A-Z])/,'\1_\2').
  downcase
end
