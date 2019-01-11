//
//  SantanderTesteiOSTests.swift
//  SantanderTesteiOSTests
//
//  Created by Vitor Neves on 05/07/2018.
//  Copyright © 2018 Vitor Neves. All rights reserved.
//

import XCTest
//@testable import AKMaskField
//@testable import Cartography
@testable import SantanderTesteiOS

class SantanderTesteiOSTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
//    func testSum() {
//        let result = RegisterVC.sum(1, 2);
//        XCTAssert(result == 4, "Valor errado da soma");
//    }
    
//    func testCheckEmail(){
//        let result = ViewController.validateEmail("ddddddd")
//    }
    
//    func validateEmail() {
//
//        var email = "12345678"
//
//        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
//        XCTAssert( emailPredicate.evaluate(with: email))
//
//    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
