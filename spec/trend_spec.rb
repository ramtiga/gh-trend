# coding: utf-8

require "spec_helper"
require "webmock/rspec"

WebMock.allow_net_connect!

describe GhTrend::Trend do
  before do
    @options = {:lang =>"ruby", :desc => true, :num => "3", :brows => nil, :star => nil, :unstar => nil}
    @client = GhTrend::Trend.new(@options)
  end

  describe "#brows?" do
    it "with no -b option" do
      @client.brows?.should be_false
    end
  end
  
  describe "#get_trend" do
    TREND_URL = "https://github.com/trending?l=ruby"
    before do
      WebMock.stub_request(:get, TREND_URL).to_return({:body => File.open(File.expand_path(File.dirname(__FILE__) + '/fixtures/gh_trend.html')), :status => 200})
    end
    
    it 'get trend data' do
      @client.get_trend

      @client.repo_nm[0].should == "Gazler/githug"
      @client.repo_nm[1].should == "pawurb/termit"
      @client.repo_nm[2].should == "webnuts/post_json"

      @client.repo_desc[0].should == "Git your game on!"
    end
  end
  
  describe "#limit_number?" do
    it 'check -n option' do
      @client.send(:limit_number?, 4).should be_true
    end
  end
end
