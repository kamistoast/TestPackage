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
public struct TestPackage<Content> where Content : View {
    
    public var content: Content
    
}

public extension TestPackage {
    
    init(@ViewBuilder _ content: () -> Content) {
        
        self.content = content()
    }

}

public extension TestPackage {
    var body: some View {
        return ScrollView {
            Text("hi")
        }
    }
}
