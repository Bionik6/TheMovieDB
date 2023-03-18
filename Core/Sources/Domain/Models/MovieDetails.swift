import Foundation


public struct MovieDetails: Identifiable {
  public let id: Int
  public let adult: Bool
  public let budget: Int
  public let video: Bool
  public let revenue: Int
  public let runtime: Int
  public let homepage: URL
  public let title: String
  public let imdbId: String
  public let status: String
  public let voteCount: Int
  public let genres: [Genre]
  public let tagline: String
  public let overview: String
  public let releaseDate: Date
  public let popularity: Double
  public let posterPath: String
  public let voteAverage: Double
  public let backdropPath: String
  public let originalTitle: String
  public let originalLanguage: String
  public let spokenLanguages: [SpokenLanguage]
  public let productionCountries: [ProductionCountry]
  
  public init(
    id: Int,
    adult: Bool,
    budget: Int,
    video: Bool,
    revenue: Int,
    runtime: Int,
    homepage: URL,
    title: String,
    imdbId: String,
    status: String,
    voteCount: Int,
    genres: [Genre],
    tagline: String,
    overview: String,
    releaseDate: Date,
    popularity: Double,
    posterPath: String,
    voteAverage: Double,
    backdropPath: String,
    originalTitle: String,
    originalLanguage: String,
    spokenLanguages: [SpokenLanguage],
    productionCountries: [ProductionCountry]
  ) {
    self.id = id
    self.adult = adult
    self.budget = budget
    self.video = video
    self.revenue = revenue
    self.runtime = runtime
    self.homepage = homepage
    self.title = title
    self.imdbId = imdbId
    self.status = status
    self.voteCount = voteCount
    self.genres = genres
    self.tagline = tagline
    self.overview = overview
    self.releaseDate = releaseDate
    self.popularity = popularity
    self.posterPath = posterPath
    self.voteAverage = voteAverage
    self.backdropPath = backdropPath
    self.originalTitle = originalTitle
    self.originalLanguage = originalLanguage
    self.spokenLanguages = spokenLanguages
    self.productionCountries = productionCountries
  }
}


public struct ProductionCountry {
  public let iso31661: String
  public let name: String
  
  public init(iso31661: String, name: String) {
    self.iso31661 = iso31661
    self.name = name
  }
}


public struct SpokenLanguage {
  public let englishName: String
  public let iso6391: String
  public let name: String
  
  public init(englishName: String, iso6391: String, name: String) {
    self.englishName = englishName
    self.iso6391 = iso6391
    self.name = name
  }
}


public struct Genre {
  public let id: Int
  public let name: String
  
  public init(id: Int, name: String) {
    self.id = id
    self.name = name
  }
}
