module AppMarketScraper::Play::Detail
  class Parser
    attr_reader :body

    def initialize(html_body, app=nil)
      @body = html_body
      @app = app
    end

    def parse
      doc = Nokogiri::HTML(body)

      if doc.css('.body-content').empty?
        raise AppMarketScraper::ParserError.new('Could not parse app store page')
      end

      begin
        unless @app.nil?
          parse_detail(doc)
          # p extract_secondary_content(doc)
        else
          @app = AppMarketScraper::Play::App.new
          parse_detail_all(doc)
        end

      rescue
        raise AppMarketScraper::ParserError.new("Could not parse app store page")
      ensure
        AppMarketScraper::Play.result.add(@app)
        AppMarketScraper::Util.play_scrap_counter
      end
      # 
      # p @app
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
      @app.name = response_html.css('.info-container .document-title .id-app-title').text.strip
    end

    def extract_developer(response_html)
      @app.developer = response_html.css('.document-subtitle [@itemprop="name"]').text.strip
    end
    def extract_package(response_html)
      @app.package = response_html.css('.details-wrapper').first['data-docid'].strip
    end

    def extract_stars(response_html)
      star = response_html.css('.tiny-star').first['aria-label'].strip
      @app.stars = pattern_match_decimal(star).to_s
    end

    def pattern_match_decimal(string)
      string.match /(\d+[.]\d+)/
    end

    def extract_url(response_html)
      # puts "COME"
      @app.url = AppMarketScraper::GOOGLE_PLAY_DETAIL_URL + "?id=#{extract_package(response_html)}".strip
    end
    def extract_image_url(response_html)
      @app.image_url = "https:" + response_html.css('.cover-container .cover-image').first['src'].strip
    end

    def extract_updated(response_html)
      @app.updated = response_html.css('.details-section-contents .meta-info [@itemprop="datePublished"]').text.strip
    end

    def extract_download(response_html)
      @app.download = response_html.css('.details-section-contents .meta-info [@itemprop="numDownloads"]').text.strip
    end

    def extract_content_rating(response_html)
      @app.content_rating = response_html.css('.details-section-contents .meta-info [@itemprop="contentRating"]').text.strip
    end

    def extract_version(response_html)
      @app.version = response_html.css('.details-section-contents .meta-info [@itemprop="softwareVersion"]').text.strip
    end

    def extract_operating_system(response_html)
      @app.operating_system = response_html.css('.details-section-contents .meta-info [@itemprop="operatingSystems"]').text.strip
    end
    
    def extract_developer_web_site(response_html)
      @app.developer_web_site = response_html.css('.details-section-contents .meta-info .contains-text-link .dev-link').at(0)['href'].strip
    end
    
    def extract_email(response_html)
      @app.email = response_html.css('.details-section-contents .meta-info .contains-text-link .dev-link')
      .at(1)['href'].strip.split(':').at(1)
    end

    def extract_address(response_html)
      @app.address = response_html.css('.details-section-contents .meta-info .content .physical-address').text.strip
    end
    # inapp-msg

    def extract_description(response_html)
      description = ""
      description << response_html.css('.main-content .description .show-more-content div').text.strip
      description << response_html.css('.main-content .description .show-more-content div p').text.strip
      @app.description = description
    end

    def extract_category(response_html)
      @app.category = response_html.css('.info-container .category @href').first.value.strip.downcase!.split("/").last
    end

    def extract_secondary_content(response_html)
      p response_html.css('.details-section-contents .cards .card .card-content .details .title')
      .first.text
    end

  end
end