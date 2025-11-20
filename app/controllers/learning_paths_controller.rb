class LearningPathsController < ApplicationController
  include Authentication
  before_action :authenticate_user!

  def index
    @tags = fetch_popular_tags
    Rails.logger.info "Fetched #{@tags.length} tags for #{current_site}: #{@tags.first(10).inspect}"
    @fundamental_tags = categorize_tags(@tags)
    Rails.logger.info "Categorized into #{@fundamental_tags.keys.length} categories"
  end

  def show
    @tag = params[:tag]
    @level = params[:level] || 'beginner'
    # Use the current site from ApplicationController
    @site = current_site

    # Fetch learning path from the Flask API
    @learning_path = fetch_learning_path(@site, @tag, @level)

    if @learning_path.nil?
      flash[:alert] = "Unable to fetch learning path for '#{@tag}'"
      redirect_to learning_paths_path
    end
  end

  private

  def fetch_popular_tags
    # Fetch from the site the user has selected
    site = current_site

    begin
      tags_data = StackexchangeApi.get_tags(site)
      if tags_data
        all_tags = tags_data.map { |t| t['tag'] }

        # Prioritize fundamental tags based on site
        fundamental_tags = case site
        when 'networkengineering'
          ['routing', 'vlan', 'subnet', 'ip', 'ethernet', 'tcp', 'switching',
           'bgp', 'ospf', 'dhcp', 'arp', 'udp', 'dns', 'spanning-tree',
           'firewall', 'vpn', 'acl', 'nat', 'ipsec', 'wireless', 'wifi',
           'wireshark', 'tcpdump', 'ping', 'cisco', 'juniper', 'mpls',
           'qos', 'multicast', 'load-balancing', 'wan', 'bandwidth']
        when 'math'
          ['calculus', 'algebra', 'geometry', 'probability', 'statistics',
           'linear-algebra', 'differential-equations', 'number-theory',
           'complex-analysis', 'topology', 'abstract-algebra', 'real-analysis',
           'combinatorics', 'graph-theory', 'optimization', 'matrices']
        else
          [] # For other sites, we'll just use whatever tags are available
        end

        # Get fundamental tags that exist in the dataset
        important = fundamental_tags.select { |tag| all_tags.include?(tag) }

        # Add more tags from the full list to get variety
        remaining = all_tags - important

        # Return important tags first, then others
        important + remaining.first(50)
      else
        []
      end
    rescue => e
      Rails.logger.error "Error fetching tags: #{e.message}"
      []
    end
  end

  def fetch_learning_path(site, tag, level)
    begin
      StackexchangeApi.get_learning_path(site, tag, level)
    rescue => e
      Rails.logger.error "Error fetching learning path: #{e.message}"
      nil
    end
  end


  def categorize_tags(tags)
    # Based on actual data from networkengineering dataset
    # Ordered by post count importance
    fundamentals = {
      'Core Fundamentals (Start Here!)' => ['routing', 'vlan', 'subnet', 'ip', 'ethernet', 'tcp', 'switching'],
      'Essential Protocols' => ['bgp', 'ospf', 'dhcp', 'arp', 'udp', 'dns', 'spanning-tree', 'stp'],
      'Network Security' => ['firewall', 'vpn', 'acl', 'nat', 'ipsec', 'ssl', 'tls'],
      'Wireless Networking' => ['wireless', 'wifi', 'access-point', 'wpa', 'ssid'],
      'Troubleshooting Tools' => ['wireshark', 'tcpdump', 'ping', 'traceroute', 'packet-capture'],
      'Vendor & Equipment' => ['cisco', 'juniper', 'arista', 'aruba', 'cisco-asa', 'cisco-nexus'],
      'Advanced Topics' => ['mpls', 'qos', 'multicast', 'load-balancing', 'redundancy', 'vxlan', 'sdn'],
      'WAN & Internet' => ['wan', 'internet', 'isp', 'bandwidth', 'latency', 'peering']
    }

    categorized = {}

    # Match tags with fundamental categories (exact match first)
    fundamentals.each do |category, keywords|
      matched_tags = []

      # First try exact matches
      keywords.each do |keyword|
        if tags.include?(keyword)
          matched_tags << keyword
        end
      end

      # Then try partial matches for remaining keywords
      unmatched_keywords = keywords - matched_tags
      unmatched_keywords.each do |keyword|
        partial_matches = tags.select { |tag| tag.downcase.include?(keyword.downcase) && !matched_tags.include?(tag) }
        matched_tags.concat(partial_matches)
      end

      categorized[category] = matched_tags.uniq if matched_tags.any?
    end

    categorized
  end
end