//
//  CircleButtonAnimation.swift
//  iExpenses
//
//  Created by Lucas Parreira on 10/07/21.
//
import SwiftUI

struct CircleButtonAnimationView: View {
    @Binding var animate : Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 3.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? Animation.easeOut(duration: 0.6) : .none)
           

    }
}

struct CircleButtonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimationView(animate: .constant(true))
            .foregroundColor(.green)
            .frame(width: 75, height: 75)
    }
}
