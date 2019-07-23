# frozen_string_literal: true

module Api
  module V1
    # Github controller
    class GitHubController < ::ApplicationController
      before_action :authenticate_request!

      def repositories
        content = GitHub.list_public_repositories
        render_content(content)
      end
    end
  end
end
