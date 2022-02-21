//
//  LoginStorageTest.swift
//  SwiftUIBootstrapTests
//
//  Created by Masroor Elahi on 21/02/2022.
//

import XCTest
import Realm
import RealmSwift

@testable import SwiftUIBootstrap

class LoginStorageTest: XCTestCase {
    
    var realmContext : RealmContextManager!
    
    override func setUp() {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }
    
    func testUserStorageSuccess() {
        realmContext = RealmContextManager(realm: try! Realm())
        let userStorage :  LoginStorageProtocol = UserStorage(storage: realmContext)
        try! userStorage.saveUserInformation(user: User.mock)
        let user = userStorage.getUserInformation(userId: 102)!
        XCTAssertTrue(user.id == 102 && user.firstName == "Masroor" && user.lastName == "Elahi")
    }
    
    func testUserNotFound() {
        
        realmContext = RealmContextManager(realm: try! Realm())
        let userStorage :  LoginStorageProtocol = UserStorage(storage: realmContext)
        try! userStorage.saveUserInformation(user: User.mock)
        let user = userStorage.getUserInformation(userId: 103)
        XCTAssertNil(user)
    }
    
    func testUserStorageFailedRealmNotInitialized() {
        realmContext = RealmContextManager(realm: nil)
        let userStorage : LoginStorageProtocol = UserStorage(storage: realmContext)
        do {
            try userStorage.saveUserInformation(user: User.mock)
        } catch RealmError.eitherRealmIsNilOrNotRealmSpecificModel {
            XCTAssert(true, "Realm is nil")
        } catch let ex {
            XCTAssert(false, "General Exception \(ex)")
        }
    }
    
}
