class ExternalDataService
  SITE_NAMES = {
    'datascience' => '5009',
    'devops' => '5008',
    'stats' => '5001',
    'dba' => '5002',
    'unix' => '5003',
    'cs' => '5004',
    'math' => '5005',
    'softwareengineering' => '5007',
    'security' => '5010',
    'serverfault' => '5011',
    'superuser' => '5012',
    'networkengineering' => '5013',
    'stackoverflow' => '5006'
  }.freeze
  def initialize(flask_app_name, site_name, node_id, endpoint)
    @flask_app_name = flask_app_name
    @node_id = node_id
    @endpoint = endpoint
    @site_name = site_name
  end

  def fetch_data
    response = perform_request
    handle_response(response)
  rescue => e
    # Log the error
    puts "An error occurred: #{e.message}"
    nil
  end

  def uri
    URI("http://#{@flask_app_name}:#{SITE_NAMES[@site_name]}/#{@endpoint}/#{@node_id}")
  end

  def perform_request
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    request["Accept"] = "application/json"
    http.request(request)
  end

  def handle_response(response)
    if response.code == "200"
      JSON.parse(response.body)
    else
      nil # You could raise a custom exception here if desired
    end
  end
end
  