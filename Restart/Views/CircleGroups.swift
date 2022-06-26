//
//  CircleGroups.swift
//  Restart
//
//  Created by Cuma Haznedar on 24.06.2022.
//

import SwiftUI

struct CircleGroups: View {

    @State var ShapeColor: Color
    @State var ShapeOpacity: Double
    @State private var isAnimiting: Bool = false


    var body: some View {
        ZStack {
            Circle()
                .stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: 40)
                .frame(width: 260, height: 260, alignment: .center)
            Circle()
                .stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: 80)
                .frame(width: 260, height: 260, alignment: .center)
        } //: ZSTACK
        .blur(radius: isAnimiting ? 0 : 10)
            .opacity(isAnimiting ? 1 : 0.5)
            .scaleEffect(isAnimiting ? 1 : 0)
            .animation(.easeOut(duration: 1), value: isAnimiting)
            .onAppear(perform: {
            isAnimiting = true
        })
    }
}

struct CircleGroups_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            CircleGroups(ShapeColor: .white, ShapeOpacity: 0.2)
        }
    }
}
