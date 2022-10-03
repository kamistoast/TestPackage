import SwiftUI

/*public struct TestPackage: View {
    
    var count: Int

    public init(count: Int) {
        
        self.count = count
    }
    
    public var body: some View {
        Text("\(count)")
            .bold()
            .foregroundColor(.red)
    }
}*/
public struct TestPackage<Content>: View where Content : View {
    
    var count: Int
    var content: Content
    
}

extension TestPackage {
    
    public init(count: Int, @ViewBuilder content: () -> Content) {
        
        self.count = count
        self.content = content()
    }

}

extension TestPackage {
    public var body: some View {
        ScrollView {
            content
        }
    }
}
