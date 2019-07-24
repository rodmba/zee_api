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

      def repository_by_keyword
        content = GitHub.search_by_keyword(search_params)
        render_content(content)
      end

      def repository_by_user
        content = GitHub.search_by_user(user: params[:user])
        render_content(content)
      end

      private

      def search_params
        {
          q: params[:keyword],
          sort: params[:sort],
          order: params[:order],
          language: params[:language],
          user: params[:user]
        }
      end
    end
  end
end
