
import XCTest
@testable import Tasks

final class StyleElementTests: XCTestCase
{
    func testEncodeResponse(){
        let style = StyleElement(separator: "#e0e3e6", background: "#ffffff", button: "#3973fd")
        print(style.dumpJSON()!)
    }
}
