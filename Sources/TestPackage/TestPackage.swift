import SwiftUI

public struct TestPackage<Content>: View where Content : View {
    
    var id: UUID
    var content: Content
    
}

extension TestPackage {
    public init(id: UUID = UUID(), @ViewBuilder content: () -> Content) {
        
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
                    proxy.scrollTo(id, anchor: .center)
                } label: {
                    Text("Scroll to")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding(.trailing)
            }
        }
    }
}
