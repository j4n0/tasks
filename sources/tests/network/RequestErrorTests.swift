
import XCTest
@testable import Tasks

class RequestErrorTests: XCTestCase
{
    struct DummyParsingError: Error {}
    let resource = Resource(path: "")
    let baseURL = URL(string: "http://baseurl.com")!
    
    // when instantiated with error code
    func testInstanceWithErrorCode()
    {
        // it returns nil if the code is not an error
        XCTAssertNil(RequestError(httpStatus: 200))
        
        // it returns .httpStatus if the code is an error
        XCTAssert(.httpStatus(400) == RequestError(httpStatus: 400))
    }
    
    // all cases have a localized description
    func testLocalizedDescription(){
        [
            RequestError.httpStatus(400),
            RequestError.unexpected,
            RequestError.parsing(DummyParsingError()),
            RequestError.invalidEndpointDefinition(resource, baseURL)
            ].forEach {
                XCTAssertNotNil($0.localizedDescription)
        }
    }
    
    func testEquatable(){
        
        // equal
        XCTAssert(.httpStatus(400) == .httpStatus(400))
        XCTAssert(RequestError.urlLoading(DummyParsingError()) == RequestError.urlLoading(DummyParsingError()))
        XCTAssert(.unexpected == .unexpected)
        XCTAssert(.parsing(DummyParsingError()) == .parsing(DummyParsingError()))
        // XCTAssert(.invalidResource(_,_) == .invalidResource(_,_))
        
        // not equal
        XCTAssert(RequestError.httpStatus(401) != .httpStatus(400))
        XCTAssert(RequestError.httpStatus(501) != .unexpected)
        XCTAssert(RequestError.httpStatus(501) != .parsing(DummyParsingError()))
        XCTAssert(RequestError.httpStatus(501) != .invalidEndpointDefinition(resource, baseURL))
    }
}

extension RequestError: Equatable {
    public static func == (lhs: RequestError, rhs: RequestError) -> Bool {
        switch (lhs, rhs) {
        case (.httpStatus(let x), .httpStatus(let y)): return x == y
        case (.urlLoading(_), .urlLoading(_)): return true
        case (.unexpected, .unexpected): return true
        case (.parsing, .parsing): return true
        case (.invalidEndpointDefinition(_, _), .invalidEndpointDefinition(_, _)): return true
        default: return false
        }
    }
}

