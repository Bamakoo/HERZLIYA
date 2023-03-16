//
//  OrdersNetworkManager.swift
//  Client
//
//  Created by Emma Gaubert on 27/02/2023.
//

import Foundation

final class OrdersNetworkManager {
    let httpClient: HttpClient
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    func fetchOrders() async throws -> [Order] {
        let url = URL(string: Request.baseURL + Endpoint.orders)!
        let orders: [Order] = try await httpClient.fetch(url: url)
        return orders
    }
    func createOrder(id: UUID, price: Int) async throws {
        guard let url = URL(string: Request.baseURL + Endpoint.orders) else {
            print("Unable to create valid URL for creating an order")
            return
        }
        let newOrder = Order(id: id, price: price)
        try await httpClient.sendData(to: url, object: newOrder, httpMethod: HttpMethods.POST.rawValue)
    }
    func updateOrder(id: UUID, price: Int) async throws {
        guard let url = URL(string: Request.baseURL + Endpoint.orders) else {
            print("Unable to create valid URL for updating an order")
            return
        }
        let updatedOrder = Order(id: id, price: price)
        try await httpClient.updateData(to: url, object: updatedOrder, httpMethod: HttpMethods.PUT.rawValue)
    }
    func deleteOrder(id: UUID) async throws {
        let url = URL(string: Request.baseURL + Endpoint.orders + "/\(id)")!
        try await httpClient.delete(url: url)
    }
}
