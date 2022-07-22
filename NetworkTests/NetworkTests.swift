//
//  NetworkTests.swift
//  NetworkTests
//
//  Created by rae on 2022/07/21.
//

import XCTest
@testable import CustomKeyboard

final class NetworkTests: XCTestCase {
    
    var endpoint: Endpoint!
    var data: Data!
    
    override func setUpWithError() throws {
        endpoint = APIEndpoints.getReviews()
        data = JSONLoader.data(fileName: "ReviewResponse")
    }

    override func tearDownWithError() throws {
        endpoint = nil
        data = nil
    }

    func test_fetchData_Data가_존재하며_statusCode가_200일때() {
        let mockURLSession = MockURLSession.make(url: endpoint.url()!, data: data, statusCode: 200)
        
        // sut(systemUnderTest) : 테스트할 클래스
        let sut = NetworkManager(session: mockURLSession)
        
        var result: ReviewResponse?
        sut.fetchData(endpoint: endpoint, dataType: ReviewResponse.self) { response in
            if case let .success(reviewResponse) = response {
                result = reviewResponse
            }
        }
        
        let expectation: ReviewResponse? = JSONLoader.load(type: ReviewResponse.self, fileName: "ReviewResponse")
        XCTAssertEqual(result?.data.count, expectation?.data.count)
        XCTAssertEqual(result?.data.first?.content, result?.data.first?.content)
    }
    
    func test_fetchData_Data가_존재하며_dataType_오류일때() {
        let mockURLSession = MockURLSession.make(url: endpoint.url()!, data: data, statusCode: 200)
        
        let sut = NetworkManager(session: mockURLSession)
        
        var result: NetworkError?
        sut.fetchData(endpoint: endpoint, dataType: User.self) { response in
            if case let .failure(error) = response {
                result = error as? NetworkError
            }
        }
        
        let expectation: NetworkError = .decodeError
        XCTAssertEqual(result, expectation)
    }
    
    func test_fetchData_Date가_없고_statusCode_400일때() {
        let mockURLSession = MockURLSession.make(url: endpoint.url()!, data: nil, statusCode: 400)
        
        let sut = NetworkManager(session: mockURLSession)
        
        var result: NetworkError?
        sut.fetchData(endpoint: endpoint, dataType: ReviewResponse.self) { response in
            if case let .failure(error) = response {
                result = error as? NetworkError
            }
        }
        
        let expectation: NetworkError = .statusCodeError
        XCTAssertEqual(result, expectation)
    }

}
