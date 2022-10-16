import XCTest
@testable import MyLibrary

class WeatherServiceIntegrationTests: XCTestCase {
    func testWeatherService() async throws {
        let weatherService = WeatherServiceImpl()
        let temp = try await weatherService.getTemperature()
        XCTAssertNotNil(temp)
        XCTAssert(temp == Int(62.08))
    }
}
