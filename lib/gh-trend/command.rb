# coding: utf-8

module GhTrend
  class Command
    # options: ARGV
    def self.run(options)
      trend = GhTrend::Trend.new(options)
      trend.get_trend

      # option: -b --brows
      return if trend.brows?

      # option: -s --star
      if trend.star?
        puts "Star a repository"
        return
      end

      # option: -u --unstar
      if trend.unstar?
        puts "Unstar a repository"
        return
      end

      trend.show
    end
  end
end

