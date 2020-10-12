import XCTest
import RxSwift

class quotes_interactor_p_valid_param_01 : XCTestCase {
    var interactor: QuotesInteractor!
    var disposeBag = DisposeBag()
    var givenDict = [String : String]()
    var whenDict = [String : String]()
    var thenDict = [String : Any]()
    var messageKey = ""
    let timeout = TimeInterval(1)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let key = String(describing: type(of: self))
        let gwt = stub_loader.gwt(key: key)
        let givenData = gwt.0!.data(using: .utf8)!
        let whenData = gwt.1!.data(using: .utf8)!
        let thenData = gwt.2!.data(using: .utf8)!
        self.messageKey = gwt.3!
        self.interactor = QuotesInteractor(client: ClientStub(data: thenData))
        do {
            self.givenDict = try JSONSerialization.jsonObject(with: givenData, options: []) as! [String : String]
            self.whenDict = try JSONSerialization.jsonObject(with: whenData, options: []) as! [String : String]
            self.thenDict = try JSONSerialization.jsonObject(with: thenData, options: []) as! [String : Any]
        } catch {
            XCTAssertTrue(false)
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let expt = expectation(description: "Waiting done unit tests...")
        var resultModel: QuotesResultModel? = nil
        var errorCode = 0
        self.interactor.requestRandomQuotes(param: QuotesParam())
            .subscribe(onSuccess: { responseModel in
                resultModel = responseModel
                expt.fulfill()
            }) { error in
                errorCode = (error as NSError).code
                expt.fulfill()
            }
            .disposed(by: self.disposeBag)
        
        waitForExpectations(timeout: self.timeout, handler: nil)
        
        // then
        XCTAssertTrue(resultModel != nil)
        XCTAssertTrue(errorCode == 0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
