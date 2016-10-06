module AppMarketScraper::Play::Detail
  class Parser
    attr_reader :body, :type

    def initialize(html_body, opts={})
      @body = html_body
      if opts[:type] == "multi"
        @type = opts[:type]
      else
        @type = "base"
      end
      opts.delete(:type)
    end

    def parse
      response_html = Nokogiri::HTML(body)

      if response_html.css('.body-content').empty?
        AppMarketScraper::ParserError.new('Could not parse app store page')
        return
      end

      @app ||= AppMarketScraper::Play::App.new
      begin
        unless type == "multi"
          parse_detail(response_html)
          return @app
        else
          parse_detail_all(response_html)
        end
      rescue
        AppMarketScraper::ParserError.new("Could not parse app store page")
      end

      if AppMarketScraper.current_size <= AppMarketScraper.app_limit
        AppMarketScraper::Play.array.add(@app)
        AppMarketScraper.play_scrap_counter
        
        AppMarketScraper::Play.package.add_collection(extract_test(response_html))
      else
        Thread.exit
      end
      
    end

    private
    def parse_detail_all(response_html)
      @app.name ||= extract_name(response_html)
      @app.developer ||= extract_developer(response_html)
      @app.stars ||= extract_stars(response_html)
      @app.package ||= extract_package(response_html)
      @app.url ||= extract_url(response_html)
      @app.image_url ||= extract_image_url(response_html)
      
      parse_detail(response_html)
    end

    def parse_detail(response_html)
      @app.email ||= extract_email(response_html)
      @app.category ||= extract_category(response_html)
      @app.updated ||= extract_updated(response_html)
      @app.download ||= extract_download(response_html)
      @app.content_rating ||= extract_content_rating(response_html)
      @app.version ||= extract_version(response_html)
      @app.operating_system ||= extract_operating_system(response_html)
      @app.address ||= extract_address(response_html)
      @app.description ||= extract_description(response_html)
      @app.developer_web_site ||= extract_developer_web_site(response_html)
    end

    def extract_name(response_html)
      response_html.css('.info-container .document-title .id-app-title').text.strip
    end

    def extract_developer(response_html)
      response_html.css('.document-subtitle [@itemprop="name"]').text.strip
    end
    def extract_package(response_html)
      response_html.css('.details-wrapper').first['data-docid'].strip
    end

    def extract_stars(response_html)
      star = response_html.css('.tiny-star').first['aria-label'].strip
      pattern_match_decimal(star).to_s
    end

    def pattern_match_decimal(string)
      string.match /(\d+[.]\d+)/
    end

    def extract_url(response_html)
      AppMarketScraper::GOOGLE_PLAY_DETAIL_URL + "?id=#{extract_package(response_html)}".strip
    end
    def extract_image_url(response_html)
      "https:" + response_html.css('.cover-container .cover-image').first['src'].strip
    end

    def extract_updated(response_html)
      response_html.css('.details-section-contents .meta-info [@itemprop="datePublished"]').text.strip
    end

    def extract_download(response_html)
      response_html.css('.details-section-contents .meta-info [@itemprop="numDownloads"]').text.strip
    end

    def extract_content_rating(response_html)
      response_html.css('.details-section-contents .meta-info [@itemprop="contentRating"]').text.strip
    end

    def extract_version(response_html)
      response_html.css('.details-section-contents .meta-info [@itemprop="softwareVersion"]').text.strip
    end

    def extract_operating_system(response_html)
      response_html.css('.details-section-contents .meta-info [@itemprop="operatingSystems"]').text.strip
    end
    
    def extract_developer_web_site(response_html)
      response_html.css('.details-section-contents .meta-info .contains-text-link .dev-link').at(0)['href'].strip
    end
    
    def extract_email(response_html)
      response_html.css('.details-section-contents .meta-info .contains-text-link .dev-link')
      .each do |value|
        email = value['href'].strip.split('mailto:').at(1)
        unless email.nil?
          return email
        end
      end
    end

    def extract_address(response_html)
      response_html.css('.details-section-contents .meta-info .content .physical-address').text.strip
    end

    def extract_description(response_html)
      description = ""
      description << response_html.css('.main-content .description .show-more-content div').text.strip
      description << response_html.css('.main-content .description .show-more-content div p').text.strip
      description
    end

    def extract_category(response_html)
      response_html.css('.info-container .category @href').first.value.strip.downcase!.split("/").last
    end

    def extract_secondary_content(response_html)
      # AppMarketScraper::GOOGLE_PLAY_BASE_URL + response_html.css('.details-section-contents .cards .card .card-content .card-click-target')
      # .first['href'].strip
      secondary_apps = []
      response_html.css('.details-section-contents .cards .card .card-content .cover .card-click-target @href')
      .each {|value| secondary_apps << AppMarketScraper::GOOGLE_PLAY_BASE_URL + value.to_s.strip }
      secondary_apps
    end

    def extract_test(response_html)
      secondary_apps = []
      response_html.css('.details-section-contents .cards .card .card-content .cover .card-click-target .preview-overlay-container @data-docid')
      .each {|value| secondary_apps << value.to_s.strip }
      secondary_apps
    end

  end
end