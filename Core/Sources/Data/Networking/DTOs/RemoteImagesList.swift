/**
 *  SuperBreed
 *  RemoteImagesList.swift
 *  Copyright (c) Ibrahima Ciss 2022
 */

import Domain
import Foundation

public struct RemoteImagesList: Decodable {
  public let images: [String]
  public let status: String
  
  public init(images: [String], status: String) {
    self.images = images
    self.status = status
  }
  
  enum CodingKeys: String, CodingKey {
    case images = "message"
    case status
  }
  
}



struct RemoteMovieDetails: Decodable {
  let adult: Bool
  let backdropPath: String
  let budget: Int
  let genres: [Genre]
  let homepage: URL
  let id: Int
  let imdbId: String
  let originalLanguage: String
  let originalTitle: String
  let overview: String
  let popularity: Double
  let posterPath: String
  let productionCountries: [ProductionCountry]
  let releaseDate: Date
  let revenue: Int
  let runtime: Int
  let spokenLanguages: [SpokenLanguage]
  let status: String
  let tagline: String
  let title: String
  let video: Bool
  let voteAverage: Double
  let voteCount: Int
}

struct ProductionCountry: Decodable {
  enum CodingKeys: String, CodingKey, CaseIterable {
    case iso31661 = "iso_3166_1"
    case name
  }
  
  let iso31661: String
  let name: String
  
  init(iso31661: String, name: String) {
    self.iso31661 = iso31661
    self.name = name
  }
}

struct SpokenLanguage: Decodable {
  enum CodingKeys: String, CodingKey, CaseIterable {
    case englishName = "english_name"
    case iso6391 = "iso_639_1"
    case name
  }
  
  let englishName: String
  let iso6391: String
  let name: String
  
  init(englishName: String, iso6391: String, name: String) {
    self.englishName = englishName
    self.iso6391 = iso6391
    self.name = name
  }
}

struct Genre: Decodable {
  enum CodingKeys: String, CodingKey, CaseIterable {
    case id
    case name
  }
  
  let id: Int
  let name: String
  
  init(id: Int, name: String) {
    self.id = id
    self.name = name
  }
}
