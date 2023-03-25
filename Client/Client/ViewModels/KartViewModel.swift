//
//  OrderViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 27/02/2023.
//

import Foundation

final class KartViewModel: ObservableObject {
    @Published var karts = [Kart]()
    private let networkManager: KartsNetworkManager
    init(networkManager: KartsNetworkManager) {
        self.networkManager = networkManager
    }
    @MainActor
    func getUsersKart() async {
        do {
            karts = try await networkManager.fetchMyKart()
        } catch {
            print(error)
        }
    }
    func addBookToKart(id: UUID, price: Int) async throws {
        do {
            try await networkManager.createOrder(id: id, price: price)
        } catch {
            print(error)
        }
    }
    func changeKart(id: UUID, price: Int) async throws {
        do {
            try await networkManager.updateOrder(id: id, price: price)
        } catch {
            print(error)
        }
    }
    func deleteBookFromKart(id: UUID) async throws {
        do {
            try await networkManager.deleteOrder(id: id)
        } catch {
            print(error)
        }
    }
}
