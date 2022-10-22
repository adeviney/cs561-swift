import XCTest
@testable import MyLibrary

class WeatherServiceIntegrationTests: XCTestCase {
    func testWeatherServiceNarrowIntegration_UnluckyTemp() async throws {
        // Given
        let mockWeatherServiceImpl: WeatherServiceImpl = WeatherServiceImpl(mock: true)
        let myLibrary = MyLibrary(weatherService: mockWeatherServiceImpl)
        
        
        // When
        let isLuckyNumber: Bool? = await myLibrary.isLucky(9)
        let temp = try await mockWeatherServiceImpl.getTemperature() // should return 62

        // Then
        XCTAssert(temp == 62)
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == false)
        // mock returns temp 62 which does not contain an 8 and therefore `isLuckyNumber` should be false
    }

    func testWeatherServiceNarrowIntegration_LuckyTemp() async throws {
        // Given
        let mockWeatherServiceImpl: WeatherServiceImpl = WeatherServiceImpl(mock: true, luckyTemp: true)
        let myLibrary = MyLibrary(weatherService: mockWeatherServiceImpl)
        
        // When
        let isLuckyNumber: Bool? = await myLibrary.isLucky(9)
        let temp = try await mockWeatherServiceImpl.getTemperature() // should return 68

        // Then
        XCTAssert(temp == 68)
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == true)
        // lucky mock returns temp 68 which contains an 8 and therefore `isLuckyNumber` should be true
    }

    func testWeatherServiceBroadIntegration() async throws {
        // Given
        var myApiKey: String? {
            ProcessInfo.processInfo.environment["API_KEY"]
        }
        let realWeatherService = WeatherServiceImpl(APIKEY: myApiKey)
        let myLibrary = MyLibrary(weatherService: realWeatherService)
    
        
        // When
        let isLuckyNumber = await myLibrary.isLucky(9)
        let temp = try await realWeatherService.getTemperature()

        
        // Then
        XCTAssertNotNil(temp)

        // reasonable temperature ranges in Corvallis at this time
        XCTAssert(temp > 45)
        XCTAssert(temp < 75)

        let tempContainsEight: Bool = String(temp).contains("8")
        XCTAssertEqual(isLuckyNumber, tempContainsEight)

    }
}
