//
//  ContentView.swift
//  Restart
//
//  Created by Cuma Haznedar on 24.06.2022.
//

import SwiftUI

struct ContentView: View {

    @AppStorage("onboarding") var isOnBoardingViewActive: Bool = true

    var body: some View {
        ZStack {
            if isOnBoardingViewActive {
                OnBoardingView()
            } else {
                HomeView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
