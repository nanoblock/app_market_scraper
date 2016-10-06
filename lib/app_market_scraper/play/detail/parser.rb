module AppMarketScraper::Play::Detail
  class Parser
    attr_reader :body

    def initialize(html_body, app=nil)
      @body = html_body
      @app = app
    end

    def parse
      response_html = Nokogiri::HTML(body)

      if response_html.css('.body-content').empty?
        puts AppMarketScraper::ParserError.new('Could not parse app store page')
        return
      end

      begin
        unless @app.nil?
          parse_detail(response_html)
          
        else
          @app = AppMarketScraper::Play::App.new
          parse_detail_all(response_html)
          
        end
        
      rescue
        puts AppMarketScraper::ParserError.new("Could not parse app store page")
      end

      
      if AppMarketScraper::Util.current_size <= AppMarketScraper.app_limit
        AppMarketScraper::Play.result.add(@app)
        AppMarketScraper::Util.play_scrap_counter
        
        AppMarketScraper::Play.array.add_collection(extract_test(response_html))

        # AppMarketScraper::Play.array.elements.each do |value|
        #   AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new(value.name).start } )
        # end

      else
        AppMarketScraper::threads.elements.each do |thread|
          thread.terminate
          # thread.stop
        end
        # puts "comecome"
        Thread.exit
        puts AppMarketScraper::ParserError.new("LIMIT")
      end
      
    end

    private
    def parse_detail_all(response_html)
      extract_name(response_html)
      extract_developer(response_html)
      extract_stars(response_html)
      extract_package(response_html)
      extract_url(response_html)
      extract_image_url(response_html)
      
      parse_detail(response_html)
    end

    def parse_detail(response_html)
      extract_email(response_html)
      extract_category(response_html)
      extract_updated(response_html)
      extract_download(response_html)
      extract_content_rating(response_html)
      extract_version(response_html)
      extract_operating_system(response_html)
      extract_address(response_html)
      extract_description(response_html)
      extract_developer_web_site(response_html)
    end

    def extract_name(response_html)
      @app.name ||= response_html.css('.info-container .document-title .id-app-title').text.strip
    end

    def extract_developer(response_html)
      @app.developer ||= response_html.css('.document-subtitle [@itemprop="name"]').text.strip
    end
    def extract_package(response_html)
      @app.package ||= response_html.css('.details-wrapper').first['data-docid'].strip
    end

    def extract_stars(response_html)
      star = response_html.css('.tiny-star').first['aria-label'].strip
      @app.stars ||= pattern_match_decimal(star).to_s
    end

    def pattern_match_decimal(string)
      string.match /(\d+[.]\d+)/
    end

    def extract_url(response_html)
      @app.url ||= AppMarketScraper::GOOGLE_PLAY_DETAIL_URL + "?id=#{extract_package(response_html)}".strip
    end
    def extract_image_url(response_html)
      @app.image_url ||= "https:" + response_html.css('.cover-container .cover-image').first['src'].strip
    end

    def extract_updated(response_html)
      @app.updated ||= response_html.css('.details-section-contents .meta-info [@itemprop="datePublished"]').text.strip
    end

    def extract_download(response_html)
      @app.download ||= response_html.css('.details-section-contents .meta-info [@itemprop="numDownloads"]').text.strip
    end

    def extract_content_rating(response_html)
      @app.content_rating ||= response_html.css('.details-section-contents .meta-info [@itemprop="contentRating"]').text.strip
    end

    def extract_version(response_html)
      @app.version ||= response_html.css('.details-section-contents .meta-info [@itemprop="softwareVersion"]').text.strip
    end

    def extract_operating_system(response_html)
      @app.operating_system ||= response_html.css('.details-section-contents .meta-info [@itemprop="operatingSystems"]').text.strip
    end
    
    def extract_developer_web_site(response_html)
      @app.developer_web_site ||= response_html.css('.details-section-contents .meta-info .contains-text-link .dev-link').at(0)['href'].strip
    end
    
    def extract_email(response_html)
      response_html.css('.details-section-contents .meta-info .contains-text-link .dev-link')
      .each do |value|
        email = value['href'].strip.split('mailto:').at(1)
        unless email.nil?
          @app.email ||= email
          return
        end
      end
    end

    def extract_address(response_html)
      @app.address ||= response_html.css('.details-section-contents .meta-info .content .physical-address').text.strip
    end

    def extract_description(response_html)
      description = ""
      description << response_html.css('.main-content .description .show-more-content div').text.strip
      description << response_html.css('.main-content .description .show-more-content div p').text.strip
      @app.description ||= description
    end

    def extract_category(response_html)
      @app.category ||= response_html.css('.info-container .category @href').first.value.strip.downcase!.split("/").last
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