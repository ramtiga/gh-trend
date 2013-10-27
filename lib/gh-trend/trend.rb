# coding: utf-8

require "nokogiri"
require "launchy"
require "httparty"

module GhTrend

  class Trend
    BASE_URL = "https://github.com/trending"
    DSP_POS = 50

    attr_reader :repo_nm, :repo_desc

    def initialize(options)
      @options = options
      @repo_nm = []
      @repo_url = []
      @repo_desc = []
      @client = GhTrend::GithubApi.new
    end

    def show
      cnt = 1

      puts "Trending #{@options[:lang].capitalize} repositories on GitHub today"
      puts "-" * 56

      @repo_nm.each do |t|

        if @client.user_authenticated?
          if @client.check_star?(t)
            star_status = "unstar"
          else
            star_status = "star"
          end
        else
          star_status = ""
        end

        puts "#{cnt.to_s}: " + t + " " * make_pos(cnt, t.length) + star_status

        if @options[:desc]
          puts make_spaces(cnt) + @repo_desc[cnt - 1]
        end
        cnt += 1

        break if limit_number?(cnt)
      end
    end

    def brows?
      if @options[:brows]
        Launchy.open "https://github.com/" + @repo_url[@options[:brows].to_i - 1]
        true
      else
        false
      end
    end

    def star?
      if @options[:star]
        @client.star(@repo_nm[@options[:star].to_i - 1])
        @repo_nm[@options[:star].to_i - 1]
      else
        false
      end
    end

    def unstar?
      if @options[:unstar]
        @client.unstar(@repo_nm[@options[:unstar].to_i - 1])
        @repo_nm[@options[:unstar].to_i - 1]
      else
        false
      end
    end

    def get_trend
      # doc = Nokogiri::HTML(open(geturl))
      doc = Nokogiri::HTML(HTTParty.get(geturl))
      doc.css('div[class="leaderboard-list-content"]').each do |html|
        @repo_nm << html.css('span[class="owner-name"]').text + "/" + html.css('strong').text
        @repo_url << html.css('a[class="repository-name"]').text
        @repo_desc << html.css('p[class="repo-leaderboard-description"]').text
      end
    end
    
    private
    def geturl
      @options[:lang] ? BASE_URL + "?l=" + @options[:lang] : BASE_URL
    end

    def make_spaces(n)
      if n < 10
        " " * 3
      else
        " " * 4
      end
    end

    def limit_number?(n)
      return false if @options[:num].nil?
      @options[:num].to_i < n
    end

    def make_pos(cnt, len)
      if cnt < 10
        DSP_POS - (3 + len)
      else
        DSP_POS - (4 + len)
      end
    end

  end
end

