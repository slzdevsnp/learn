import Foundation

public struct MemoryUtil {
    
    
    /// Retrieves the address of value type objects
    ///
    /// - parameter o: <#o description#>
    ///
    /// - returns: <#return value description#>
    public static func address(_ o: UnsafeRawPointer) -> String {
        let address = unsafeBitCast(o, to: Int.self)
        return String(format:"%p", address)
    }
    
    /// Retrieves the address of reference type (class) instance on the heap
    ///
    /// - parameter ref: reference type instance
    ///
    /// - returns: address of instance
    public static func address<T: AnyObject>(_ ref: T) -> String {
        let address = unsafeBitCast(ref, to: Int.self)
        return String(format:"%p", address)
    }
}
