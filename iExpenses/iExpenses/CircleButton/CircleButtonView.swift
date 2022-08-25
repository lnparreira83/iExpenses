//
//  CircleButtonView.swift
//  iExpenses
//
//  Created by Lucas Parreira on 10/07/21.
//

import SwiftUI

struct CircleButtonView: View {
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.green)
            .frame(width:40, height: 40)
            .background(
                Circle()
                    .foregroundColor(Color(.white))
                    .opacity(0.15)
            )
            .shadow(color: Color.blue.opacity(0.5), radius: 8, x: 0, y: 0)
            .padding()
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            CircleButtonView(iconName: "info")
                .previewLayout(.sizeThatFits)
            
            CircleButtonView(iconName: "plus")
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
