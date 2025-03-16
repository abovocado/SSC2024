import SwiftUI

struct ContentView: View {
    @Binding var isShowingContentView: Bool
    @State var selection = 0
    
    var body: some View {
        VStack {
            if selection == 0 {
                StoryView()
            } else if selection == 1 {
                BrailleView()
            } else if selection == 2 {
                TranslationView()
            }
            
            HStack {
                GreenButton(action: {
                    if selection == 0 {
                        self.isShowingContentView = false
                    } else {
                        selection -= 1
                    }
                }) {
                    Label("Prev", systemImage: "chevron.backward.2")
                }
                
                Spacer()
                
                GreenButton(action: {
                    if selection == 2 {
                        self.isShowingContentView = false
                    } else {
                        selection += 1
                    }
                }) {
                    if selection == 2 {
                        Label("Home", systemImage: "house.fill")
                    } else {
                        Label("Next", systemImage: "chevron.forward.2")
                            .labelStyle(.trailingIcon)
                    }
                }
                .buttonStyle(GreenButtonStyle())
            }
            .padding(.horizontal)
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.keyboard)
        .onTapGesture {
            hideKeyboard()
        }
    }
}

func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}
