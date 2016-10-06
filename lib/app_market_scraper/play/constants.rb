module AppMarketScraper::Play
  CATEGORY = 'apps'

  CATEGORY_CONSTANTS = { 
    health_and_fitness: 'HEALTH_AND_FITNESS',
    education: 'EDUCATION',
    finance: 'FINANCE',
    weather: 'WEATHER',
    news_and_magazine: 'NEWS_AND_MAGAZINES',
    dating: 'DATING',
    personalization: 'PERSONALIZATION',
    tools: 'TOOLS',
    books_and_reference: 'BOOKS_AND_REFERENCE',
    video_players: 'VIDEO_PLAYERS',
    libraries_and_demo: 'LIBRARIES_AND_DEMO',
    lifestyle: 'LIFESTYLE',
    comics: 'COMICS',
    house_and_home: 'HOUSE_AND_HOME',
    beauty: 'BEAUTY',
    business: 'BUSINESS',
    photography: 'PHOTOGRAPHY',
    productivity: 'PRODUCTIVITY',
    social: 'SOCIAL',
    shopping: 'SHOPPING',
    sports: 'SPORTS',
    food_and_drink: 'FOOD_AND_DRINK',
    entertainment: 'ENTERTAINMENT',
    travel_and_local: 'TRAVEL_AND_LOCAL',
    art_and_design: 'ART_AND_DESIGN',
    music_and_audio: 'MUSIC_AND_AUDIO',
    medical: 'MEDICAL',
    events: 'EVENTS',
    auto_and_vehicles: 'AUTO_AND_VEHICLES',
    maps_and_navigation: 'MAPS_AND_NAVIGATION',
    parenting: 'PARENTING',
    communication: 'COMMUNICATION',
    android_wear: 'ANDROID_WEAR',
    game: 'GAME',
    game_educational: 'GAME_EDUCATIONAL',
    game_word: 'GAME_WORD',
    game_role_playing: 'GAME_ROLE_PLAYING',
    game_board: 'GAME_BOARD',
    game_sports: 'GAME_SPORTS',
    game_simulation: 'GAME_SIMULATION',
    game_arcade: 'GAME_ARCADE',
    game_action: 'GAME_ACTION',
    game_adventure: 'GAME_ADVENTURE',
    game_music: 'GAME_MUSIC',
    game_racing: 'GAME_RACING',
    game_strategy: 'GAME_STRATEGY',
    game_card: 'GAME_CARD',
    game_casino: 'GAME_CASINO',
    game_casual: 'GAME_CASUAL',
    game_trivia: 'GAME_TRIVIA',
    game_puzzle: 'GAME_PUZZLE',
    family: 'FAMILY',
    family_age_range1: '?age=AGE_RANGE1',
    family_age_range2: '?age=AGE_RANGE2',
    family_age_range3: '?age=AGE_RANGE3',
    family_education: 'FAMILY_EDUCATION',
    family_braingames: 'FAMILY_BRAINGAMES',
    family_action: 'FAMILY_ACTION',
    family_pretend: 'FAMILY_PRETEND',
    family_musicvideo: 'FAMILY_MUSICVIDEO',
    family_create: 'FAMILY_CREATE'
  }

  def self.category
    # puts "come"
    @category ||= CATEGORY
  end

  # def self.category_constants
  #   @category_constants ||= CATEGORY_CONSTANTS
  # end

  def self.category_constants(value="game")
    @category_constants ||= CATEGORY_CONSTANTS
    if @category_constants.has_key?(value.to_sym)
      return @category_constants[value.to_sym]
    end
    AppMarketScraper::ParamsError.new("#{value} is not exsist google apps category")
  end

end