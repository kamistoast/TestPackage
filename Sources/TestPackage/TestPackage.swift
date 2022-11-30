import SwiftUI

public struct TestPackage<Content>: View where Content : View {
    
    var id: AnyHashable
    var content: Content
    @State var isVisible: Bool = true
    @State var currentPosition: Double = 0.0
    @State var savedPosition: Double = 0.0
}

extension TestPackage {
    public init(id: AnyHashable, @ViewBuilder content: () -> Content) {
        
        self.id = id
        self.content = content()
    }

}

extension TestPackage {
    public var body: some View {
        
        ScrollViewReader { proxy in
            ScrollView(
                axes: .vertical,
                showsIndicators: false,
                offsetChanged: {

                    if isVisible {
                        currentPosition = $0.y
                    } else {
                        savedPosition = $0.y
                    }
                                
                }) {
                content
            }
            .overlay {
                Button {
                    //with animation
                        proxy.scrollTo(id, anchor: .center)
                        isVisible.toggle()
                        
                    
                } label: {
                    ZStack {
                        Circle()
                            .foregroundColor(.black)
                            .frame(width: 40, height: 40)
                        
                        Image(systemName: "chevron.down")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding(.trailing)
                .opacity(isVisible ? 1 : 0)
                .onChange(of: savedPosition) { _ in
                    if currentPosition != savedPosition {
                        print("\(currentPosition) and \(savedPosition)")
                    }
                }
            }
        }
    }
}
