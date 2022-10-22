import XCTest
@testable import MyLibrary


final class MyLibraryTests: XCTestCase {
    func testIsLuckyBecauseWeAlreadyHaveLuckyNumber() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(8)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == true)
    }

    func testIsLuckyBecauseWeatherHasAnEight() async throws {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: true
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(0)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == true)
    }

    func testIsNotLucky() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(7)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == false)
    }

    func testIsNotLuckyBecauseServiceCallFails() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: false,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(7)

        // Then
        XCTAssertNil(isLuckyNumber)
    }

        // ------- Weather Model Tests ------- //
        func testWeatherModel_canDeserializeSimpleJSONtoTemp() throws {
        // Given
        let json = """
        {"main":
            {
                "temp": 67.5
            }
        }   
        """.data(using: .utf8)!

        // When
        let weather = try JSONDecoder().decode(Weather.self, from: json)
        // Then
        XCTAssertNotNil(weather)
        XCTAssert((weather as Any) is Weather)
        XCTAssert((weather.main.temp as Any) is Double)
        XCTAssert(weather.main.temp == 67.5)
    }


        func testWeatherModel_canDeserializeSampleResponseJSONtoTemp() throws {
        // Given
        let filePath = try XCTUnwrap(Bundle.module.path(forResource: "sampleResponse", ofType: "json"))
        let jsonString = try String(contentsOfFile: filePath)
        let jsonData = Data(jsonString.utf8)

        // When
        let weather = try JSONDecoder().decode(Weather.self, from: jsonData)

        // Then
        XCTAssertNotNil(weather)
        XCTAssert((weather as Any) is Weather)
        XCTAssert((weather.main.temp as Any) is Double)
        XCTAssert(weather.main.temp == 69.15)

    }
}