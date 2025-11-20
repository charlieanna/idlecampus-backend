class UserDataService
  def initialize(user)
    @user = user
  end

  def fetch_and_process_data(site_names)
    tag_weights_all = {}
    results_all = {}
    user_ids = {}

    fetch_associated_data() # Presuming this is now coming from your database
    site_names.keys.each do |site_name|
      user_data = fetch_user_data_from_db(site_name) # Now pulling from the database
      if user_data
        user_id, account_id, _, _ = user_data.values_at("user_id", "account_id", "display_name", "reputation")
        user_ids[site_name] = user_id

        # tag_weights = fetch_tag_weights_from_db(site_name) # Now pulling from the database
        tag_weights = {} # Initialize tag_weights as empty hash for now
        results = aggregate_results(user_data["reputation"], @user.associated_data)
        tag_weights_all[site_name] = tag_weights
        results_all[site_name] = results
      end
    end
    return user_ids, tag_weights_all, results_all
  end

  private

  def aggregate_results(reputation, associated_data)
    # Simple aggregation logic - can be customized based on requirements
    {
      reputation: reputation || 0,
      site_count: associated_data.is_a?(Hash) && associated_data["items"] ? associated_data["items"].size : 0
    }
  end

  def fetch_associated_data
    # Parse associated_data if it's a string
    associated_data = if @user.associated_data.is_a?(String)
      begin
        JSON.parse(@user.associated_data)
      rescue JSON::ParserError
        {}
      end
    else
      @user.associated_data || {}
    end

    if !associated_data.key?("items")
      associated_response = ApiService.api_get_request("/me/associated?access_token=#{@user.access_token}")
      json_associated_response = JSON.parse(associated_response)
      if json_associated_response.key?("items")
        @user.associated_data = json_associated_response.to_json
        @user.save
      end
      return json_associated_response
    end
    return associated_data
  end

  def fetch_user_data_from_db(site_name)
    user_data = @user.user_data

    # Parse user_data if it's a string
    if user_data.is_a?(String)
      begin
        JSON.parse(user_data)
      rescue JSON::ParserError
        {}
      end
    else
      user_data || {}
    end
  end

  def fetch_tag_weights_from_db(site_name)
    # Fetch from your database, for example from a TagWeights model:
    TagWeight.where(user_id:  @user.user_id, site_name: site_name)
  end
end
