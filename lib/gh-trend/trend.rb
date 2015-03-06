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

      title_dsp

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
      return false unless @options[:brows]
      Launchy.open "https://github.com" + @repo_url[@options[:brows].to_i - 1]
      true
    end

    def star?
      return false unless @options[:star]
      @client.star(@repo_nm[@options[:star].to_i - 1])
      @repo_nm[@options[:star].to_i - 1]
      true
    end

    def unstar?
      return false unless @options[:unstar]
      @client.unstar(@repo_nm[@options[:unstar].to_i - 1])
      @repo_nm[@options[:unstar].to_i - 1]
      true
    end

    def get_trend
      doc = Nokogiri::HTML(HTTParty.get(geturl))
      doc.css('li[class="repo-list-item"]').each do |html|
        repo_url = html.css('h3 > a').attribute('href').value
        m = repo_url.match(/\/(.+)\/(.+)/)
        @repo_nm << m[1] + "/" + m[2]
        @repo_url << repo_url
        @repo_desc << html.css('p[class="repo-list-description"]').text.strip
      end
    end
    
    private
    def geturl
      @options[:lang] ? BASE_URL + "?l=" + @options[:lang] : BASE_URL
    end

    def make_spaces(n)
      n < 10 ? " " * 3 : " " * 4
    end

    def limit_number?(n)
      return false if @options[:num].nil?
      @options[:num].to_i < n
    end

    def make_pos(cnt, len)
      cnt < 10 ? DSP_POS - (3 + len) : DSP_POS - (4 + len)
    end

    def title_dsp
      puts "Trending #{@options[:lang].capitalize} repositories on GitHub today"
      puts "-" * 56
    end

  end
end

