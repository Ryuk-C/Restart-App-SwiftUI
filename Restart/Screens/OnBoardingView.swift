//
//  OnBoardingView.swift
//  Restart
//
//  Created by Cuma Haznedar on 24.06.2022.
//

import SwiftUI

struct OnBoardingView: View {

    @AppStorage("onboarding") var isOnBoardingViewActive: Bool = true

    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimiting: Bool = false
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacicity: Double = 1.0
    @State private var textTitle: String = "Share."

    let hapticFeedback = UINotificationFeedbackGenerator()

    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)

            VStack(spacing: 20) {


                Spacer()

                VStack(spacing: 0) {

                    //MARK: - HEADER

                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .transition(.opacity)
                        .foregroundColor(.white)
                        .id(textTitle)

                    Text("""
                        It's not how much we give but
                        how much love we put into giving.
                        """)
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)

                } //: HEADER
                .opacity(isAnimiting ? 1 : 0)
                    .offset(y: isAnimiting ? 0 : -40)
                    .animation(.easeInOut(duration: 1), value: isAnimiting)
                ZStack {

                    //MARK: - CENTER

                    CircleGroups(ShapeColor: .white, ShapeOpacity: 0.2)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOffset)

                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimiting ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimiting)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .gesture(DragGesture()
                            .onChanged { gesture in
                            if abs(imageOffset.width) <= 150 {
                                imageOffset = gesture.translation

                                withAnimation(.linear(duration: 0.25)) {
                                    indicatorOpacicity = 0
                                    textTitle = "Give."
                                }
                            }

                        }
                            .onEnded { _ in
                            imageOffset = .zero
                            withAnimation(.linear(duration: 0.25)) {
                                indicatorOpacicity = 1.0
                                textTitle = "Share."
                            }

                        }
                    )
                        .animation(.easeOut(duration: 1), value: imageOffset)

                } //: CENTER
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y: 20)
                        .opacity(isAnimiting ? 1 : 0)
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimiting)
                        .opacity(indicatorOpacicity)
                    , alignment: .bottom)

                Spacer()

                ZStack {

                    //MARK: - FOOTER

                    // 1. BACKGROUND (STATIC)

                    Capsule()
                        .fill(Color.white.opacity(0.2))

                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)

                    // 2. CALL-TO-ACTION (STATIC)

                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)

                    // 3. CAPSULE (DYNAMIC WIDTH)

                    HStack {

                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 80)

                        Spacer()

                    }

                    // 4. CIRCLE (DRAGGABLE)

                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("ColorRed"))

                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)

                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                            .foregroundColor(.white)
                            .frame(width: 80, height: 80, alignment: .center)
                            .offset(x: buttonOffset)
                            .gesture (
                            DragGesture()
                                .onChanged { gesture in
                                if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {

                                    buttonOffset = gesture.translation.width

                                }

                            }
                                .onEnded { _ in
                                withAnimation(Animation.easeOut(duration: 0.4)) {
                                    if buttonOffset > buttonWidth / 2 {
                                        hapticFeedback.notificationOccurred(.success)
                                        playSound(sound: "chimeup", type: "mp3")
                                        buttonOffset = buttonWidth - 80
                                        isOnBoardingViewActive = false
                                    } else {
                                        hapticFeedback.notificationOccurred(.warning)
                                        buttonOffset = 0

                                    }
                                }

                            }

                        )

                        Spacer()

                    }

                } //: FOOTER
                .frame(width: buttonWidth, height: 80, alignment: .center)
                    .padding()
                    .opacity(isAnimiting ? 1 : 0)
                    .offset(y: isAnimiting ? 0 : 40)
                    .animation(.easeOut(duration: 1), value: isAnimiting)
            }
        }
            .onAppear(perform: {
            isAnimiting = true
        })

            .preferredColorScheme(.dark)
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
