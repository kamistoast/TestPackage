import SwiftUI

public struct TestPackage<Content>: View where Content : View {
    
    var id: AnyHashable
    var content: Content
    @State var isVisible: Bool = true
    @State var toggle: Bool = false
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

                    //saves the items position where you scrolled to
                    if toggle {
                        savedPosition = $0.y
                        toggle.toggle()
                    }
                    
                    // makes button visible again
                    if isVisible == false && toggle == false && savedPosition != $0.y {
                        withAnimation {
                            isVisible.toggle()
                        }
                    }
                                
                }) {
                content
            }
            .overlay {
                Button {
                        proxy.scrollTo(id, anchor: .center)
                        isVisible.toggle()
                        toggle.toggle()
                        
                    
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

            }
        }
    }
}
