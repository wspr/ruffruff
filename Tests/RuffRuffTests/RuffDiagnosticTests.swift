import XCTest
@testable import RuffRuff

final class RuffDiagnosticTests: XCTestCase {
    func testDiagnosticSeverity() {
        let error = RuffDiagnostic.Severity.error
        let warning = RuffDiagnostic.Severity.warning
        
        XCTAssertEqual(error.color, "red")
        XCTAssertEqual(warning.color, "orange")
    }
    
    func testDiagnosticCreation() {
        let diagnostic = RuffDiagnostic(
            line: 10,
            column: 5,
            endLine: 10,
            endColumn: 15,
            code: "E501",
            message: "Line too long",
            severity: .error
        )
        
        XCTAssertEqual(diagnostic.line, 10)
        XCTAssertEqual(diagnostic.column, 5)
        XCTAssertEqual(diagnostic.code, "E501")
        XCTAssertEqual(diagnostic.message, "Line too long")
        XCTAssertEqual(diagnostic.severity, .error)
    }
}
