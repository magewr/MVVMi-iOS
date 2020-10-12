import XCTest
import RxSwift

class main_viewmodel_p_invalid_parse_01: XCTestCase {
    var disposeBag = DisposeBag()
    var givenDict = [String : String]()
    var whenDict = [String : String]()
    var thenData: Data!
    var messageKey = ""
    let timeout = TimeInterval(5)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let key = String(describing: type(of: self))
        let gwt = stub_loader.gwt(key: key)
        let givenData = gwt["given"]!.data(using: .utf8)!
        let whenData = gwt["when"]!.data(using: .utf8)!
        self.thenData = gwt["then"]!.data(using: .utf8)!
        self.messageKey = gwt["messageKey"]!
        do {
            self.givenDict = try JSONSerialization.jsonObject(with: givenData, options: []) as! [String : String]
            self.whenDict = try JSONSerialization.jsonObject(with: whenData, options: []) as! [String : String]
        } catch {
            XCTAssertTrue(false)
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /// Parsing Error 일 때 핸들링 처리 테스트
    func testmain_viewmodel_p_invalid_parse_01() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expt = expectation(description: "Waiting done unit tests...")
        let dependency = MainViewModel.Dependency(quotesInteractor: QuotesInteractorStub(resultData: thenData))
        let viewModel = MainViewModel(dependency: dependency)
        var results: String?
        var messageKey: String?
        viewModel.output.getRandomQuotesResult
            .subscribe(onNext: { quotes in
                results = quotes
                expt.fulfill()
            })
            .disposed(by: self.disposeBag)
        
        viewModel.output.error
            .subscribe(onNext: { errorKey in
                messageKey = errorKey
                expt.fulfill()
            })
            .disposed(by: self.disposeBag)

        viewModel.input.getRandomQuotes.onNext(())
        waitForExpectations(timeout: self.timeout, handler: nil)
        
        // then
        XCTAssertTrue(results == nil)
        XCTAssertTrue(messageKey != nil)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
