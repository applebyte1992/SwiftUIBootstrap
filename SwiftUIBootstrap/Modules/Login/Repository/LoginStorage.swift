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

class LoginStorage : BaseDatabaseStorage , LoginStorageProtocol {
    func saveUserInformation() {
//        self.storage?.save(object: <#T##Storable#>)
        print("Save")
    }
    
    
}
