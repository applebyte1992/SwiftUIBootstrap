//
//  LoginStorage.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 16/02/2022.
//

import Foundation


protocol LoginStorageProtocol : BaseStorageClient {
    func saveUserInformation()
}


var abc = LoginStorage(storage: RealmContextManager())

class LoginStorage : BaseDatabaseStorage , LoginStorageProtocol {
    func saveUserInformation() {
        print("Save")
    }
}



