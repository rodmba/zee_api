# frozen_string_literal: true

# This class retrieve information from GitHub API
class GitHub
  def initialize
    @repositories_suffix = "repositories"
  end

  attr_reader :repositories_suffix

  def self.list_public_repositories
    new.list_filtered_public_repositories
  end

  def list_filtered_public_repositories
    repos = http_get_content(repositories_suffix)
    sanitized_repositories(repos)
  end

  private

  def http_get_content(action)
    response = Faraday.get(URI.join(ENV["GIT_HUB_API_URL"], action))
    JSON.parse(response.body)
  end

  def sanitized_repositories(repos)
    repos.map do |repo|
      {
        full_name: repo["full_name"],
        description: repo["description"],
        stargazers_count: repo["stargazers_count"],
        forks_count: repo["forks_count"],
        owner: repo["owner"]["login"]
      }
    end
  end
end
