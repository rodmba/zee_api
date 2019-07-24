# frozen_string_literal: true

# This class retrieve information from GitHub API
class GitHub
  def initialize(options = {})
    @keyword = options[:q]
    @sort = options[:sort]
    @order = options[:order]
    @language = options[:language]
    @user = options[:user]
  end

  attr_reader :keyword, :sort, :order, :language, :user

  def self.list_public_repositories
    new.list_sanitized_repositories
  end

  def self.search_by_keyword(options)
    new(options).search_by_keyword
  end

  def self.search_by_user(options)
    new(options).search_by_user
  end

  def list_sanitized_repositories
    repos = http_get_content("repositories")
    sanitized_repositories(repos)
  end

  def search_by_keyword
    repos = http_get_content("/search/repositories",
                             q: keyword_query,
                             sort: sort,
                             order: order)
    sanitized_repositories(repos["items"])
  end

  def search_by_user
    repos = http_get_content("users/#{user}/repos",
                             sort: sort,
                             order: order)
    sanitized_repositories(repos)
  end

  private

  def http_get_content(action, params = {})
    response = Faraday.get(URI.join(ENV["GIT_HUB_API_URL"], action), params)
    JSON.parse(response.body)
  end

  def keyword_query
    if keyword.nil?
      "language:#{language || 'ruby'}"
    else
      "#{keyword}+language:#{language || 'ruby'}"
    end
  end

  def sanitized_repositories(repos)
    repos.map do |repo|
      {
        full_name: repo["full_name"],
        description: repo["description"],
        stargazers_count: repo["stargazers_count"],
        forks_count: repo["forks_count"],
        owner: repo["owner"]["login"],
        language: repo["language"]
      }
    end
  end
end
