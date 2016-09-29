class AppMarketScraper::Util

  def self.fix_url(url)
    url =~ /\A\/\// ? "https:#{url}" : url
  end

  def self.request_opts(opts)
    opts ||= {}
    opts[:timeout] ||= AppMarketScraper.timeout
    opts[:connecttimeout] ||= AppMarketScraper.connect_timeout
    opts[:ssl_verifypeer] = false
    opts[:ssl_verifyhost] = 2
    # opts[:c] = 'apps'
    opts[:headers] ||= {}
    opts[:headers]['User-Agent'] ||= AppMarketScraper.user_agent
    # opts[:user_agent] ||= AppMarketScraper.user_agent
    opts
  end

end