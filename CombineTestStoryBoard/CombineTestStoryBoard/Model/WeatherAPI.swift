//
//  WeatherAPI.swift
//  CombineTestStoryBoard
//
//  Created by 武田孝騎 on 2021/11/24.
//

import Foundation
import Combine

protocol WeatherFetchable {
  func weeklyWeatherForecast(
    forCity city: String
  ) -> AnyPublisher<WeeklyForecastResponse, Error>

  func currentWeatherForecast(
    forCity city: String
  ) -> AnyPublisher<CurrentWeatherForecastResponse, Error>
}

class WeatherFetcher {
  private let session: URLSession
  
  init(session: URLSession = .shared) {
    self.session = session
  }
}

// MARK: - OpenWeatherMap API
private extension WeatherFetcher {
  struct OpenWeatherAPI {
    static let scheme = "https"
    static let host = "api.openweathermap.org"
    static let path = "/data/2.5"
    static let key = "29374e9d26b36311d87e60eb3ec2cfa1"
  }
  
  func makeWeeklyForecastComponents(
    withCity city: String
  ) -> URLComponents {
    var components = URLComponents()
    components.scheme = OpenWeatherAPI.scheme
    components.host = OpenWeatherAPI.host
    components.path = OpenWeatherAPI.path + "/forecast"
    
    components.queryItems = [
      URLQueryItem(name: "q", value: city),
      URLQueryItem(name: "mode", value: "json"),
      URLQueryItem(name: "units", value: "metric"),
      URLQueryItem(name: "APPID", value: OpenWeatherAPI.key)
    ]
    
    return components
  }
  
  func makeCurrentDayForecastComponents(
    withCity city: String
  ) -> URLComponents {
    var components = URLComponents()
    components.scheme = OpenWeatherAPI.scheme
    components.host = OpenWeatherAPI.host
    components.path = OpenWeatherAPI.path + "/weather"
    
    components.queryItems = [
      URLQueryItem(name: "q", value: city),
      URLQueryItem(name: "mode", value: "json"),
      URLQueryItem(name: "units", value: "metric"),
      URLQueryItem(name: "APPID", value: OpenWeatherAPI.key)
    ]
    
    return components
  }
}

// MARK: - WeatherFetchable
extension WeatherFetcher: WeatherFetchable {
  func weeklyWeatherForecast(
    forCity city: String
  ) -> AnyPublisher<WeeklyForecastResponse, Error> {
    return forecast(with: makeWeeklyForecastComponents(withCity: city))
  }

  func currentWeatherForecast(
    forCity city: String
  ) -> AnyPublisher<CurrentWeatherForecastResponse, Error> {
    return forecast(with: makeCurrentDayForecastComponents(withCity: city))
  }

  private func forecast<T>(
    with components: URLComponents
  ) -> AnyPublisher<T, Error> where T: Decodable {
    // 1
    guard let url = components.url else {
      let error = WeatherError.network(description: "Couldn't create URL")
      return Fail(error: error).eraseToAnyPublisher()
    }

    // 2
    return session.dataTaskPublisher(for: URLRequest(url: url))
      // 3
      .mapError { error in
        WeatherError.network(description: error.localizedDescription)
      }
      // 4
      .flatMap(maxPublishers: .max(1)) { pair in
        decode(pair.data)
      }
      // 5
      .eraseToAnyPublisher()
  }
}
