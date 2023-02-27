//
//  OrderViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 27/02/2023.
//

import Foundation

final class OrderViewModel: ObservableObject {
    @Published var orders = [Order]()
    
    private let networkManager: OrdersNetworkManager
    
    init(networkManager: OrdersNetworkManager) {
        self.networkManager = networkManager
    }
    
    @MainActor
    func fetchOrders() async {
        do {
            orders = try await networkManager.fetchOrders()
        }
        catch {
            print("\(error)")
        }
    }
    func createOrder(title: String, genre: String, price: Int, author: String) async throws {
        do {
            try await networkManager.createOrder(title: title, genre: genre, price: price, author: author)
        }
        catch {
            print("\(error)")
        }
    }
    
    func updateOrder(author: String, title: String, id: UUID, price: Int, genre: String) async throws {
        do {
            try await networkManager.updateOrder(author: author, title: title, id: id, price: price, genre: genre)
        }
        catch {
            print(error)
        }
    }
    func deleteOrder(id: UUID) async throws {
        do {
            try await networkManager.deleteOrder(id: id)
        }
        catch {
            print(error)
        }
    }
}
