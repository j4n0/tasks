
import XCTest
@testable import Tasks

final class StyleElementsTests: XCTestCase
{
    func testEncodeResponse(){
        let style = StyleElements(separator: "#e0e3e6", background: "#ffffff", button: "#3973fd")
        print(style.dumpJSON()!)
    }
}
