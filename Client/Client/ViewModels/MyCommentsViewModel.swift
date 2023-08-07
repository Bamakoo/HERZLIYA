//
//  MyCommentsViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 04/07/2023.
//

import Foundation

@MainActor

final class MyCommentsViewModel: ObservableObject {

    @Published var myComments = [Comment]()

    func fetchMyComments() async throws {
        do {
            myComments = try await UseCase.Comments.fetchMyComments()
        } catch {
            print(error.localizedDescription)
        }
    }
}
