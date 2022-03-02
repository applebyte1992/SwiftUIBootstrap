//
//  BaseRepositoryProtocols.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 16/02/2022.
//

import Foundation

class BaseRepository<Network: BaseNetworkServiceClient> {
    var client: Network
    required init(client: Network) {
        self.client = client
    }
}

class BaseRepositoryStorage<Storage: BaseStorageClient , Network: BaseNetworkServiceClient> {
    var storage: Storage
    var client: Network
    required init(client: Network , storage: Storage) {
        self.storage = storage
        self.client = client
    }
}
