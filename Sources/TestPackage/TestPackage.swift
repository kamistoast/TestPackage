import SwiftUI

public struct TestPackage<Content>: View where Content : View {
    
    var id: AnyHashable
    var content: Content
    
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
            ScrollView {
                content
            }
            .overlay {
                Button {
                    withAnimation {
                        proxy.scrollTo(id, anchor: .center)
                        print(proxy)
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

            }
        }
    }
}
