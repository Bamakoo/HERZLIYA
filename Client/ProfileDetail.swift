//
//  ProfileDetail.swift
//  Client
//
//  Created by Emma Gaubert on 02/04/2023.
//

import SwiftUI

struct ProfileDetail: View {
    let linkName: String
    var body: some View {
        Text(linkName)
    }
}

struct ProfileDetail_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetail(linkName: "")
    }
}
