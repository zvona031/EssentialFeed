//
//  XCTTestCase+MemoryLeakTracking.swift
//  EssentialFeedTests
//
//  Created by Zvonimir Pavlović on 08.12.2022..
//

import XCTest

extension XCTestCase {

    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potentional memory leak", file: file, line: line)
        }
    }
}
