//
//  NotificationsBar.swift
//  NetflixSwiftUI
//
//  Created by Radhi MIGHRI on 17/09/2023.
//

import SwiftUI

struct NotificationsBar: View {
    //MARK: - Properties
    @Binding var showNotificationsList: Bool
    
    //MARK: - View
    var body: some View {
        Button {
            showNotificationsList = true
        } label: {
            HStack {
                Image(systemName: "bell")
                Text("Notifications")
                    .bold()
                Spacer()
                Image(systemName: "chevron.right")
            }
            .font(.system(size: 18, weight: .bold))
        }
        .foregroundColor(.white)
        .padding()
    }
}

//MARK: - Previews
struct NotificationsBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            NotificationsBar(showNotificationsList: .constant(false))
        }
    }
}
