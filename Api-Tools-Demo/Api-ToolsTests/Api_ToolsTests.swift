//
//  Api_ToolsTests.swift
//  Api-ToolsTests
//
//  Created by Joey BARBIER on 23/07/2022.
//

import XCTest
import OrkaApiRouter

class Api_ToolsTests: XCTestCase {
}

// MARK: - Test With Completion Block
extension Api_ToolsTests {
    
    // MARK: - Convert To Object
    func testCallToObject() {
        let expectation = XCTestExpectation(description: "testCallToObject")
        ApiRouter.Todo.list.call { (result: Result<[Todo], Error>) in
            switch result {
            case .failure:
                XCTFail()
            case .success:
                break
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testCallToFakeObject() {
        let expectation = XCTestExpectation(description: "testCallToFakeObject")
        ApiRouter.Todo.list.call { (result: Result<[TodoFakeModel], Error>) in
            switch result {
            case .failure:
               break
            case .success:
                // is a fake object
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    // MARK: - Convert To Data
    func testCallToData() throws {
        // Custom handler result :
        ApiRouter.Todo.list.call { (result: Result<Data, Error>) in
            switch result {
            case .failure(let error):
                print("call -> Data : \(error.localizedDescription)")
            case .success(let data):
                let result = String(data: data, encoding: .utf8) ?? ""
                print("Data : \(result)")
            }
        }
    }
    
    // MARK: - Void
    func testCallToVoid() throws {
        // No handler (for example: pixel tracker ...) :
        ApiRouter.Todo.list.call { (result: Result<Void, Error>) in
            switch result {
            case .failure(let error):
                print("call -> Void : \(error.localizedDescription)")
            case .success():
                print("success")
            }
        }
    }
}

// MARK: - Test With Concurrency
extension Api_ToolsTests {

    // MARK: - Convert To Object
    func testCallToObjectWithConcurrency() async throws {
        let _: [Todo] = try await ApiRouter.Todo.list.call()
    }
    
    func testCallToFakeObjectWithConcurrency() async throws {
        do {
            let _: [TodoFakeModel] = try await ApiRouter.Todo.list.call()
            XCTFail()
        } catch {
            // nothing is a fake object
        }
    }
    
    // MARK: - Convert To Data
    func testCallToDataWithConcurrency() async throws {
        let _: [Todo] = try await ApiRouter.Todo.list.call()
    }
    
    // MARK: - Void
    func testCallToVoidWithConcurrency() async throws {
        let _: Void = try await ApiRouter.Todo.list.call()
    }
}
