module RequestHelpers
  def parsed_response_body
    JSON.parse(response.body).with_indifferent_access
  end
end