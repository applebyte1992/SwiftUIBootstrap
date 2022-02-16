//
//  BaseDatabaseStorage.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 16/02/2022.
//

import Foundation


protocol BaseStorageClient : AnyObject { }
extension BaseStorageClient { }

class BaseDatabaseStorage {
    public var storage: BaseStorageContext
    required public init(storage : BaseStorageContext) {
        self.storage = storage
    }
}
