json.ignore_nil!

json.response do

  json.error do
    if @error_msg.present?
      json.message @error_msg[:msg]
    end
  end

  if @data
    json.data @data
  else
    json.data JSON.parse(yield)
  end
end