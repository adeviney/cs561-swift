import Alamofire
import Foundation

public protocol WeatherService {
    func getTemperature() async throws -> Int
}

class WeatherServiceImpl: WeatherService {
    private let mock: Bool
    private let luckyTemp: Bool
    private let APIKEY: String

    public init(APIKEY: String? = nil, mock: Bool? = nil, luckyTemp: Bool? = nil) {
        self.mock = mock ?? false
        self.luckyTemp = luckyTemp ?? false
        self.APIKEY = APIKEY ?? "1234"
    }

    func getTemperature() async throws -> Int {
            let BaseURL: () -> String = {
            switch self.mock {
                case true:
                    switch self.luckyTemp {
                        case true:
                            return "http://localhost:3000/lucky"
                        default:
                            return "http://localhost:3000"
                    }
                default:
                    return "https://api.openweathermap.org"
                }
            }
    
        
    let url = "\(BaseURL())/data/2.5/weather?q=corvallis&units=imperial&appid=\(APIKEY)"
            return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: Weather.self) { response in
                switch response.result {
                case let .success(weather):
                    let temperature = weather.main.temp
                    let temperatureAsInteger = Int(temperature)
                    continuation.resume(with: .success(temperatureAsInteger))

                case let .failure(error):
                    continuation.resume(with: .failure(error))
                }
            }
        } 
    }
}

    
struct Weather: Decodable {
    let main: Main

    struct Main: Decodable {
        let temp: Double
    }
}
