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
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('facebook').start } )
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('아프리카 흑점').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('어비스리움').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('이따줄께').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('커플앱 비트윈').start }) 
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('신한').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('정확한 날씨 기상').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('번개챗').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('배경화면 HD').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('알람 시계').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('슈퍼 밝은 LED').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('갓피플성경').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('네이버').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('MX 플레이어').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('네이버 미디어 플레이어').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('Premium License for PICASATOOL').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('Cardboard').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('Food Planner').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('Fitbit').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('화해').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('스트레스해소 이엔해피').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('아라').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('네이버 웹툰').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('다방').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('공짜 화장품').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('스키니데님').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('Google 문서').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('잡코리아').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('컬러노트 메모장').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('Google 캘린더').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('Google 포토').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('Snapchat').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('PicsArt').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('instagram').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('dropbox').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('zoom cloud meetings').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('아자르').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('dramy').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('sago mini').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('Alchemy 나만의 실험실').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('word slayer').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('가짜톡').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('두뇌개발 초성퀴즈').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('서머너즈 워').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('로스트킹덤').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('스타 워즈 : 커맨더').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('리버스 오브 포춘 2').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('Splendor').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('롤링 스카이').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('쿵푸사커').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('브리지 생성자').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('레알팜').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('Swing').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('잔디').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('슬랙').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('Vector').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('스노우브라더스').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('온 오프 믹스').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('마인크래프트').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('히어로 스트라이크').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('픽셀 건 3D').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('Anger of Stick 2').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('EA SPORTS UFC').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('문명의 시대').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('Cops N Robbers').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('Hardest Escape Game').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('limbo').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('A Dance of Fire and Ice').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('비트 MP3').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('아스팔트 8').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('무료 Bike Race').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('런타스틱').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('오프로드 힐 산악인').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('Need for Speed').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('래디안트 디펜스').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('클래시 오브 클랜').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('Reigns').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('디오에스').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('고스톱').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('아쿠아슬롯').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('포커페이스').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('Temple Run').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('바비의 매지컬 패션').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('헬로키티 커피 숍').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('Fruit Ninja').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('아재개그').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('넌센스').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('퍼즐로드').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('숨은그림찾기').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('라코').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('모닝카페').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('가로세로 낱말맞추기').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('물다이어리').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('Monument Valley').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('심시티빌드잇').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('네이버 밴드').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('뮤직 박스').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('멜론').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('기타 조율').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('Sago Mini 비행기').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('Toca Kitchen 2').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('디즈니').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('Card Wars').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('스왐피').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('2048').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('옐로 브릭스').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('별자리표').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('뽀로로콘').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('Coco 결혼식').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('키즈월드').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('똑똑박사 에디의 수과학놀이').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('다이닝코드').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('배달의민족').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('직방').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('중고나라').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('원스').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('위시빈').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('마이리얼트립').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('프립').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('정오의 데이트').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('스노우').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('TED').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('지그재그').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('Pinterest').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('에어비엔비').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('지진정보알리미').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('쿠팡').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('톡투미').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('현대Hmall').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('트렐로').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('청구서').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('자비스').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('사이다').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('marvel').start })
    # AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new('롯데시네마').start })

    # search_keyword = ['facebook']

    # 5.times.map {|i| 
    #   AppMarketScraper.threads.add(Thread.new { AppMarketScraper::Play::Search::Scraper.new(search_keyword.get(i)).start } )
    # }

    # "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    p AppMarketScraper.app_limit = 5
    p AppMarketScraper.app_limit 
    
    AppMarketScraper::Play::Category::Scraper.new(
      # type: "base", 
      category: AppMarketScraper::Play.category_constants("health_and_fitness")).start
    
    # Parallel.each(['facebook','티맵','카카오톡'], in_threads: 4) {|item|
    #   raise Parallel::Kill if item == 1 || AppMarketScraper.current_size == AppMarketScraper.app_limit
    #   puts "Item: #{item}, Worker: #{Parallel.worker_number}"
    #   AppMarketScraper::Play::Search::Scraper.new(item, type: "multi").start
    #   raise Parallel::Break
    # }

    # while AppMarketScraper::Play.package.size > 1 do
    #   Parallel.each(AppMarketScraper::Play.package.array, in_threads: AppMarketScraper::Play.package.array.size) {|item|
    #     raise Parallel::Kill if item == 1 || AppMarketScraper::Util.current_size == AppMarketScraper.app_limit
    #     puts "Item: #{item}, Worker: #{Parallel.worker_number}"
    #     AppMarketScraper::Play::Search::Scraper.new(item, type: "multi").start
    #   }
    # end

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

    # CSV.open("../result.csv", "w+", :headers => header, :write_headers => true) do |csv|
    #   AppMarketScraper::Play.result.array.each do |value|
    #     # csv << value
    #     csv << [value.name, value.email, value.category, value.developer, value.package,
    #       value.stars, value.download, value.updated, value.content_rating, value.version,
    #       value.operating_system, value.address, value.description, value.url, value.image_url,
    #       value.developer_web_site]
    #   end
    # end
    puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@ E N D @@@@@@@@@@@@@@@@@@@@@@@@@@@"


    # AppMarketScraper::Play.result.elements.each do |value|
    #       p value.name
    #       p value.email
    #       p value.category
    #       p value.developer
    #       p value.package
    #       p value.stars
    #       p value.download
    #       p value.updated
    #       p value.content_rating
    #       p value.version
    #       p value.operating_system
    #       p value.address
    #       p value.url
    #       p value.image_url
    #       p value.developer_web_site
    #       puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    # end

  end

  it 'do DetailScraper class validator' do
    # AppMarketScraper::Play::Detail::Scraper.new('com.facebook.moments').start
    # AppMarketScraper::Play.result.elements.each do |value|
    #   p value.name
    #   p value.email
    #   p value.category
    #   p value.developer
    #   p value.package
    #   p value.stars
    #   p value.download
    #   p value.updated
    #   p value.content_rating
    #   p value.version
    #   p value.operating_system
    #   p value.address
    #   p value.url
    #   p value.image_url
    #   p value.developer_web_site
    # end
    
  end

  it 'do AppArray class validator' do
    # expect(AppMarketScraper::Util::AppArray.new.type ).to eq "play"
    # app = AppMarketScraper::Play::App.new
    # array = [AppMarketScraper::Play::App.new, AppMarketScraper::Play::App.new, AppMarketScraper::Play::App.new]
    # expect(AppMarketScraper::Util::AppArray.new(app).add_collection(array).delete_all.size ).not_to eq nil
  end

end
