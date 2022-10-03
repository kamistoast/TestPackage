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

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct TestPackage<Content> where Content : View {
    
    public init(@ViewBuilder content: () -> Content) {}
    
}
