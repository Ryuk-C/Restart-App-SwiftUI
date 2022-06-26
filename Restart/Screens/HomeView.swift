//
//  HomeView.swift
//  Restart
//
//  Created by Cuma Haznedar on 24.06.2022.
//

import SwiftUI

struct HomeView: View {

    @AppStorage("onboarding") var isOnBoardingViewAction: Bool = false
    @State private var isAnimiting: Bool = false


    var body: some View {
        VStack(spacing: 20) {

            Spacer()

            ZStack {

                CircleGroups(ShapeColor: .gray, ShapeOpacity: 0.1)

                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y: isAnimiting ? 35 : -35)
                    .animation(
                    Animation
                        .easeInOut(duration: 4)
                        .repeatForever(),
                    value: isAnimiting
                )


            } // HEADER
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        isAnimiting = true
                    })
            })

            Spacer()


            HStack {

                Text("The time that leads to mastery is dependent on the intesity of our focus.")
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding()

            } // CENTER

            HStack {

                Button(action: {
                    withAnimation {
                        playSound(sound: "success", type: "m4a")
                        isOnBoardingViewAction = true
                    }

                }) {
                    Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                        .imageScale(.large)

                    Text("Restart")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    .controlSize(.large)

            } // FOOTER

        }

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
