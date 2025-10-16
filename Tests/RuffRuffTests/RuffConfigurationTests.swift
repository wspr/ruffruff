import XCTest
@testable import RuffRuff

final class RuffConfigurationTests: XCTestCase {
    func testDefaultConfiguration() {
        let config = RuffConfiguration()
        
        XCTAssertEqual(config.lineLength, 88)
        XCTAssertEqual(config.selectRules, ["E", "F", "W"])
        XCTAssertTrue(config.ignoreRules.isEmpty)
        XCTAssertTrue(config.excludePatterns.isEmpty)
    }
    
    func testToCommandLineArgs() {
        var config = RuffConfiguration()
        config.lineLength = 100
        config.selectRules = ["E", "F"]
        config.ignoreRules = ["E501"]
        
        let args = config.toCommandLineArgs()
        
        XCTAssertTrue(args.contains("--line-length"))
        XCTAssertTrue(args.contains("100"))
        XCTAssertTrue(args.contains("--select"))
        XCTAssertTrue(args.contains("E,F"))
        XCTAssertTrue(args.contains("--ignore"))
        XCTAssertTrue(args.contains("E501"))
    }
    
    func testEmptySelectRules() {
        var config = RuffConfiguration()
        config.selectRules = []
        config.ignoreRules = []
        
        let args = config.toCommandLineArgs()
        
        XCTAssertTrue(args.contains("--line-length"))
        XCTAssertFalse(args.contains("--select"))
        XCTAssertFalse(args.contains("--ignore"))
    }
}
