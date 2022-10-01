import SwiftUI

public struct TestPackage: View {
    
    var count: Int

    public init(count: Int) {
        
        self.count = count
    }
    
    public var body: some View {
        Text("\(count)")
    }
}
