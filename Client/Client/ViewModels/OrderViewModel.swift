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
    func createOrder(id: UUID, price: Int) async throws {
        do {
            try await networkManager.createOrder(id: id, price: price)
        }
        catch {
            print("\(error)")
        }
    }
    
    func updateOrder(id: UUID, price: Int) async throws {
        do {
            try await networkManager.updateOrder(id: id, price: price)
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
