import Foundation

public struct MemoryUtil {
    
    /// Retrieves the address of value type objects
    ///
    /// - parameter o: unsafe pointer
    ///
    /// - returns: address of undafe pointer
    public static func address(_ o: UnsafeRawPointer) -> String {
        let address = unsafeBitCast(o, to: Int.self)
        return String(format:"%p", address)
    }    
}
