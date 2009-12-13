require 'net/http'
class Facebooker::Service::NetHttpService <Facebooker::Service::BaseService
  def post_form(url,params)
    Net::HTTP.post_form(url, post_params(params))
  end
  
  def post_multipart_form(url,params)
    Net::HTTP.post_multipart_form(url, params)
  end
  
  
end


#Net::HTTP::Proxy('10.0.6.251', '3128').post_multipart_form(url, params)
#Net::HTTP::Proxy('10.0.6.251', '3128').post_form(url, post_params(params))