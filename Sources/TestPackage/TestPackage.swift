import SwiftUI

public struct TestPackage<Content>: View where Content : View {
    
    var id: AnyHashable
    var content: Content
    @State var isVisible: Double = 1
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
                    
                    if isVisible == 0 {
                        //gets the y postion (vertical)
                        currentPosition = $0.y
                        print("\(currentPosition) unsichtbar")
                    }
                    
                    if isVisible == 0 && currentPosition != $0.y {
                        isVisible = 1
                        print("changed")
                    }
                    
                    print("\(currentPosition) und \(savedPosition)")
                }) {
                content
            }
            .overlay {
                Button {
                    withAnimation {
                        proxy.scrollTo(id, anchor: .center)
                        isVisible = 0
                        savedPosition = currentPosition
                        
                    }
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
                .opacity(isVisible)
            }
        }
    }
}
