# coding: utf-8

require "octokit"

module GhTrend
  class GithubApi
    def initialize
      @client = Octokit::Client.new :netrc => File.exist?(ENV["HOME"] + "/.netrc")
      begin
        @authenticate = !@client.user.nil?
      rescue
        @authenticate = false
      end
    end

    def user_authenticated?
      @authenticate
    end

    # GET /user/starred/:owner/:repo
    def check_star?(repo)
      # repo = []
      # repo << args
      @client.starred?(repo)
    end

    def star(repo)
      @client.star(repo)
    end

    def unstar(repo)
      @client.unstar(repo)
    end

  end
end
