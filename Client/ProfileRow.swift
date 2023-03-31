//
//  ProfileRow.swift
//  Client
//
//  Created by Emma Gaubert on 30/03/2023.
//

import SwiftUI

struct ProfileRow: View {
    let linkName: String
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(linkName)
                    .font(.body)
                Spacer()
                Image(systemName: "chevron.right.circle.fill")
                    .foregroundColor(Color(.systemGray3))
                    .font(.system(size: 20))
            }
            .contentShape(Rectangle())
            .padding(EdgeInsets(top: 17, leading: 21, bottom: 17, trailing: 21))
            Divider()
        }
    }
}

struct ProfileRow_Previews: PreviewProvider {
    static var previews: some View {
        ProfileRow(linkName: "")
    }
}
