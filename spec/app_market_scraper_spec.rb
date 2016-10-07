require 'spec_helper'
require 'csv'

describe AppMarketScraper do
  it 'has a version number' do
    # @app = AppMarketScraper::Util::AppArray.new
    # @app = AppMarketScraper::Play::Search::Scraper.new('facebook').start
    # @app = AppMarketScraper::Play::Detail::Scraper.new('com.facebook.katana').start
    # p @app

    # Parallel.each(['facebook','티맵','카카오톡'], in_threads: 4) {|item|
    #   puts "Item: #{item}, Worker: #{Parallel.worker_number}"
    #   AppMarketScraper::Play::Search::Scraper.new(item, type: "multi").start
    #   raise Parallel::Break
    # }
    

    expect(AppMarketScraper::VERSION).not_to be nil
  end

  it 'do SearchScraper class validator' do
    target_app = %w(
    facebook 
    아프리카흑점 
    어비스리움 
    이따줄께 
    비트윈  
    신한 
    정확한날씨기상 
    번개챗 
    배경화면HD 
    알람시계 
    슈퍼밝은LED 
    갓피플성경 
    네이버 
    MX플레이어 
    네이버미디어플레이어 
    PICASATOOL 
    Cardboard 
    FoodPlanner 
    Fitbit 
    화해 
    스트레스해소이엔해피 
    아라 
    네이버웹툰 
    다방 
    공짜화장품 
    스키니데님 
    Google문서 
    잡코리아 
    컬러노트메모장 
    Google캘린더 
    Google포토 
    Snapchat 
    PicsArt 
    instagram 
    dropbox 
    zoomcloudmeetings 
    아자르 
    dramy 
    sagomini 
    Alchemy나만의실험실 
    wordslayer 
    가짜톡 
    두뇌개발
    초성퀴즈 
    서머너즈워 
    로스트킹덤 
    스타 워즈 
    리버스오브포춘2 
    Splendor 
    롤링스카이 
    쿵푸사커 
    브리지생성자 
    레알팜 
    Swing 
    잔디 
    슬랙 
    Vector 
    스노우브라더스 
    온오프믹스 
    마인크래프트 
    히어로스트라이크 
    픽셀건3D 
    AngerofStick2 
    EASPORTSUFC 
    문명의시대 
    CopsNRobbers 
    HardestEscapeGame 
    limbo 
    "A Dance of Fire and Ice "
    비트MP3 
    아스팔트8 
    무료BikeRace 
    런타스틱 
    오프로드힐산악인 
    NeedforSpeed 
    래디안트디펜스 
    클래시오브클랜 
    Reigns 
    디오에스 
    고스톱 
    아쿠아슬롯 
    포커페이스 
    TempleRun 
    바비의매지컬패션 
    헬로키티커피숍 
    FruitNinja 
    아재개그 
    넌센스 
    퍼즐로드 
    숨은그림찾기 
    라코 
    모닝카페 
    가로세로
    낱말맞추기 
    물다이어리 
    MonumentValley 
    심시티빌드잇 
    네이버밴드 
    뮤직박스 
    멜론 
    기타조율 
    SagoMini비행기 
    TocaKitchen2 
    디즈니 
    CardWars 
    스왐피 
    2048 
    옐로브릭스 
    별자리표 
    뽀로로콘 
    Coco결혼식 
    키즈월드 
    똑똑박사에디의수과학놀이 
    다이닝코드 
    배달의민족 
    직방 
    중고나라 
    원스 
    위시빈 
    마이리얼트립 
    프립 
    정오의데이트 
    스노우 
    TED 
    지그재그 
    Pinterest 
    에어비엔비 
    지진정보알리미 
    쿠팡 
    톡투미 
    현대Hmall 
    트렐로 
    청구서 
    자비스 
    사이다
    marvel 
    롯데시네마)

    puts "@@@@@@@@@@@@@@@@@@@ Scrap Google App Start @@@@@@@@@@@@@@@@@@@"
    AppMarketScraper.app_limit = 20000
    # AppMarketScraper::Play::Category::Scraper.new(
    #   category: AppMarketScraper::Play.categorys_find_by_key("health_and_fitness")).start
    
    Parallel.each(AppMarketScraper::Play.categorys.values, in_threads: AppMarketScraper::Play.categorys.size) {|item|
      raise Parallel::Kill if item == 1 || AppMarketScraper.current_size == AppMarketScraper.app_limit
      puts "Item: #{item}, Thread Worker: #{Parallel.worker_number}"
      AppMarketScraper::Play::Search::Scraper.new(item, type: "multi").start
    }
    Thread::list.each {|t| Thread::kill(t) if t != Thread::current}
    
    while AppMarketScraper::Play.package.size > 1 do
      Parallel.each(AppMarketScraper::Play.package.array, in_threads: AppMarketScraper::Play.package.array.size) {|item|
        raise Parallel::Kill if AppMarketScraper.current_size == AppMarketScraper.app_limit
        puts "Item: #{item}, Worker: #{Parallel.worker_number}"
        AppMarketScraper::Play::Search::Scraper.new(item, type: "multi").start
      }
      Thread::list.each {|t| Thread::kill(t) if t != Thread::current}
    end

    # "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    # 
    puts "@@@@@@@@@@@@@@@@@@@ CSV file write start @@@@@@@@@@@@@@@@@@@"
    header = ["name", "email", "category", "developer", "package", "stars", "download", "updated",
      "content_rating", "version", "operating_system", "address", "description", "url", "image_url",
      "developer_web_site"]
    #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    # csv_data = CSV.generate("result.csv", :headers => header, :write_headers => true) do |csv|
    #   AppMarketScraper::Play.result.elements.each do |value|
    #     csv << Array.new(value)
    #   end
    # end
    #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

    CSV.open("../smta_play_ko.csv", "w+", :headers => header, :write_headers => true) do |csv|
      AppMarketScraper::Play.result.array.each do |value|
        # csv << value
        csv << [value.name, value.email, value.category, value.developer, value.package,
          value.stars, value.download, value.updated, value.content_rating, value.version,
          value.operating_system, value.address, value.description, value.url, value.image_url,
          value.developer_web_site]
      end
    end
    puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@ E N D @@@@@@@@@@@@@@@@@@@@@@@@@@@"

  end

end
