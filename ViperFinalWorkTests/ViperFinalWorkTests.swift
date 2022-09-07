//
//  ViperFinalWorkTests.swift
//  ViperFinalWorkTests
//
//  Created by emre usul on 25.04.2022.
//

import XCTest
@testable import ViperFinalWork



class ViperFinalWorkTests: XCTestCase {
    
    var presenter: HomePresenter!
    var view:MockViewController!
    var interactor:MockInteractor!
    var router: MockRouter!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        view = .init()
        interactor = .init()
        router = .init()
       presenter = .init(view: view, router: router, interactor: interactor)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        view = nil
        presenter = nil
        interactor = nil
        router = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
    }
    
    func test_viewWillAppear_InvokesRequiredViewMethod() {
        XCTAssertFalse(view.isInvokedShowLoading , "Value came true, But should have been false")
        XCTAssertFalse(view.isInvokedHideLoading , "Value came true, But should have been false")
        XCTAssertFalse(view.isInvokedSetupTable ,"Value came true, But should have been false" )
        XCTAssertFalse(view.isInvokedSetTitle , "Value came true, But should have been false" )
        XCTAssertFalse(view.isInvokedCollection , "Value came true, But should have been false")
        XCTAssertFalse(view.isInvokedSetupTable ,"Value came true, But should have been false" )
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.isInvokedShowLoading , "Value came false, But should have been true")
        XCTAssertTrue(view.isInvokedSetupTable ,"Value came false, But should have been true" )
        XCTAssertTrue(view.isInvokedCollection , "Value came false, But should have been true")
        XCTAssertTrue(view.isInvokedSetupTable ,"Value came false, But should have been true" )
      
        
    
        
    }

    func test_FetchUpcomingMovie() throws {
        XCTAssertNil(presenter.movie(0)?.title , "The movie array should not be full at the beginning")
        XCTAssertEqual(presenter.numberOfRows(), 0)
        presenter.fetchMoviesListOutput(result: .success(MovieListResult.response))
        
        XCTAssertEqual(presenter.movie(0)?.title, "The Outfit")
        XCTAssertEqual(presenter.numberOfItems(), 20)
    }

}


extension MovieListResult {
    static var response: MovieListResponse {
        let bundle = Bundle(for: ViperFinalWorkTests.self)
        let path = bundle.path(forResource: "Movie", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let movieResponse = try! JSONDecoder().decode(MovieListResponse.self, from: data)
        return movieResponse
    }
}
