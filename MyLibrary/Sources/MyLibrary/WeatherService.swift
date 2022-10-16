import Alamofire
import Foundation

public protocol WeatherService {
    func getTemperature() async throws -> Int
}

class WeatherServiceImpl: WeatherService {

    enum BaseURL: String {
        case OpenWeatherMap = "https://api.openweathermap.org"
        case MockWeather = "http://localhost:3000"
    }
    
    let url = "\(BaseURL.OpenWeatherMap.rawValue)/data/2.5/weather?q=corvallis&units=imperial&appid=d7c9477357dddb826aec055177569789"

    func getTemperature() async throws -> Int {
        AF.request(url).response { response in
            debugPrint(response)
            print("making network request")
        }
        print("outside network")
        return 62
        

        //     return try await withCheckedThrowingContinuation { continuation in
        //     AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: Weather.self) { response in
        //         switch response.result {
        //         case let .success(weather):
        //             let temperature = weather.main.temp
        //             let temperatureAsInteger = Int(temperature)
        //             continuation.resume(with: .success(temperatureAsInteger))

        //         case let .failure(error):
        //             continuation.resume(with: .failure(error))
        //         }
        //     }
        // }
    }
}

    
struct Weather: Decodable {
    let main: Main

    struct Main: Decodable {
        let temp: Double
    }
}