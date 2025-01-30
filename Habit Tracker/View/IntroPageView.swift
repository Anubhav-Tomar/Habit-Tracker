//
//  IntroPageView.swift
//  Habit Tracker
//
//  Created by Anubhav Tomar on 28/01/25.
//

import SwiftUI

struct IntroPageView: View {
    
    @State private var selectedItem: IntroPageItem = staticIntroItems.first!
    @State private var introItems: [IntroPageItem] = staticIntroItems
    @State private var activeIndex: Int = 0
    @State private var askUsername: Bool = false
    
    @AppStorage("username") private var username: String = ""
    @AppStorage("isIntroCompleted") private var isIntroCompleted: Bool = false
    
    var body: some View {
        VStack {
            // Back Button
            Button {
                updateItem(isForward: false)
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3.bold())
                    .foregroundStyle(.green.gradient)
                    .contentShape(.rect)
            }
            .padding(15)
            .frame(maxWidth: .infinity, alignment: .leading)
            // Only visible from second item
            .opacity(selectedItem.id != introItems.first?.id ? 1 : 0)
            
            ZStack {
                // Animated icon
                ForEach(introItems) { item in
                    AnimatedIconView(item)
                }
            }
            .frame(height: 250)
            .frame(maxHeight: .infinity)
            
            VStack(spacing: 6) {
                // Progress Indicator View
                HStack(spacing: 4) {
                    ForEach(introItems) { item in
                        Capsule()
                            .fill(selectedItem.id == item.id ? Color.primary : .gray)
                            .frame(width: selectedItem.id == item.id ? 25 : 4,
                                   height: 4)
                    }
                }
                .padding(.bottom, 15)
                
                Text(selectedItem.title)
                    .font(.title.bold())
                    .contentTransition(.numericText())
                
                Text(selectedItem.description)
                    .contentTransition(.numericText())
                    .font(.caption2)
                    .foregroundStyle(.gray)
                
                // Continue Button
                Button {
                    if selectedItem.id == introItems.last?.id {
                        askUsername.toggle()
                    }
                    updateItem(isForward: true)
                } label: {
                    Text(selectedItem.id == introItems.last?.id ? "Continue" : "Next")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .contentTransition(.numericText())
                        .frame(width: 250)
                        .padding(.vertical, 12)
                        .background(.green.gradient, in: .capsule)
                }
                .padding(.top, 25)
            }
            .multilineTextAlignment(.center)
            .frame(width: 300)
            .frame(maxHeight: .infinity)
        }
        .ignoresSafeArea(.keyboard, edges: .all)
        .overlay {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(.black.opacity(askUsername ? 0.3 : 0))
                    .ignoresSafeArea()
                    .onTapGesture {
                        askUsername = false
                    }
                
                if askUsername {
                    UswernameView()
                        .transition(.move(edge: .bottom).combined(with: .offset(y: 100)))
                }
            }
            .animation(.snappy, value: askUsername)
        }
    }
    
    @ViewBuilder
    func AnimatedIconView(_ item: IntroPageItem) -> some View {
        let isSelected = selectedItem.id == item.id
        Image(systemName: item.image)
            .font(.system(size: 80))
            .foregroundStyle(.white.shadow(.drop(radius: 10)))
            .frame(width: 120, height: 120)
            .background(.green.gradient, in: .rect(cornerRadius: 32))
            .background {
                RoundedRectangle(cornerRadius: 35)
                    .fill(.background)
                    .shadow(color: .primary.opacity(0.2), radius: 1, x: 1, y: 1)
                    .shadow(color: .primary.opacity(0.2), radius: 1, x: -1, y: -1)
                    .padding(-3)
                    .opacity(selectedItem.id == item.id ? 1 : 0)
            }
        // Reseting rotation
            .rotationEffect(.init(degrees: -item.rotaion))
            .scaleEffect(isSelected ? 1.1 : item.scale, anchor: item.anchor)
            .offset(x: item.offset)
            .rotationEffect(.init(degrees: item.rotaion))
        
        // Placing active items at top
            .zIndex(isSelected ? 2 : item.zindex)
    }
    
    // User name view
    @ViewBuilder
    func UswernameView() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Let's Start With Your Name")
                .font(.caption)
                .foregroundStyle(.gray)
            
            TextField("Name", text: $username)
                .applyPaddedBackground(10, hPadding: 15, vPadding: 12)
                .opacityShadow(.blue, opacity: 0.1, radius: 5)
            
            Button {
                isIntroCompleted = true
            } label: {
                Text("Start Tracking Your Habits")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .hSpacing(.center)
                    .padding(.vertical, 12)
                    .background(.green.gradient, in: .rect(cornerRadius: 10))
            }
            .disableWithOpacity(username.isEmpty)
            .padding(.top, 10)
        }
        .applyPaddedBackground(12)
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }
    
    // Update icon
    func updateItem(isForward: Bool) {
        guard isForward ? activeIndex != introItems.count - 1 : activeIndex != 0 else { return }
        
        var fromIndex: Int
        var extraOffset: CGFloat
        
        if isForward {
            activeIndex += 1
        } else {
            activeIndex -= 1
        }
        
        if isForward {
            fromIndex = activeIndex - 1
            extraOffset = introItems[activeIndex].offset
        } else {
            extraOffset = introItems[activeIndex].offset
            fromIndex = activeIndex + 1
        }
        
        // Reseting zindex
        for index in introItems.indices {
            introItems[index].zindex = 0
        }
        
        Task { [fromIndex, extraOffset] in
            withAnimation(.bouncy(duration: 1)) {
                introItems[fromIndex].scale = introItems[activeIndex].scale
                introItems[fromIndex].rotaion = introItems[activeIndex].rotaion
                introItems[fromIndex].anchor = introItems[activeIndex].anchor
                introItems[fromIndex].offset = introItems[activeIndex].offset
                
                introItems[activeIndex].offset = extraOffset
                
                introItems[fromIndex].zindex = 1
            }
            
            try? await Task.sleep(for: .seconds(0.1))
            
            withAnimation(.bouncy(duration: 0.9)) {
                introItems[activeIndex].scale = 1
                introItems[activeIndex].rotaion = .zero
                introItems[activeIndex].anchor = .center
                introItems[activeIndex].offset = .zero
                
                selectedItem = introItems[activeIndex]
            }
        }
    }
}

#Preview {
    IntroPageView()
}
