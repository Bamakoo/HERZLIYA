//
//  OrdersNetworkManager.swift
//  Client
//
//  Created by Emma Gaubert on 27/02/2023.
//

import Foundation

final class OrdersNetworkManager {
    
    let httpClient: HttpClient
    
    init(httpClient: HttpClient){
        self.httpClient = httpClient
    }
    
    func fetchOrders() async throws -> [Order] {
        let url = URL(string: Request.baseURL + Endpoint.orders)!
        let orders: [Order] = try await httpClient.fetch(url: url)
        return orders
    }
    
    func createOrder() async throws {
        let url = URL(string: Request.baseURL + Endpoint.orders)!
        let newOrder = Order(id: , buyer: <#T##User#>, seller: <#T##User#>, price: , books: <#T##[Book]#>)
        try await httpClient.sendData(to: url, object: newOrder, httpMethod: HttpMethods.POST.rawValue)
    }
    
    func updateOrder() async throws {
        guard let url = URL(string: Request.baseURL + Endpoint.orders) else {
            print("Unable to create valid URL")
            return
        }
        let updatedOrder = Order(id: <#T##UUID#>, buyer: <#T##User#>, seller: <#T##User#>, price: <#T##Int#>, books: <#T##[Book]#>)
        
        try await httpClient.updateData(to: url, object: updatedOrder, httpMethod: HttpMethods.PUT.rawValue)
        print("request sent")
    }
    
    func deleteOrder(id: UUID) async throws {
        let url = URL(string: Request.baseURL + Endpoint.orders + "/\(id)")!
        try await httpClient.delete(url: url)
    }
}
