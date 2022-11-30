import SwiftUI

public struct TestPackage<Content>: View where Content : View {
    
    var id: AnyHashable
    var content: Content
    @State var isVisible: Double = 1
    @State var position: Double = 0.0
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
                    //gets the y postion (vertical)
                    if isVisible == 1 {
                        position = $0.y

                    }
                    
                    if isVisible == 0 && position != $0.y {
                        isVisible = 1
                    }

                }) {
                content
            }
            .overlay {
                Button {
                    withAnimation {
                        proxy.scrollTo(id, anchor: .center)
                        isVisible = 0
                        
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
