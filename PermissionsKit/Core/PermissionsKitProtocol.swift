import Foundation

public typealias PermissionsKitResponse = (PermissionsKitStatus) -> Void

public protocol PermissionsKitProtocol: class {

    /// The permission's identifier.
    var identifier: String { get }

    /// Used to determine the permissions current status.
    ///
    /// - Parameter completion: Callback with current permission status.
    func status(completion: @escaping PermissionsKitResponse)

    /// Use this method to automatically manage the request for a permission.
    /// The behaviour is based on the PermissionsKitConfiguration set during the initialization phase.
    ///
    /// - Parameter completion: Callback with current permission status.
    func manage(completion: @escaping PermissionsKitResponse)

    /// Use this method to manually manage the request for a permission.
    /// This will burn your only chance for the system to prompt for permissions.
    ///
    /// - Parameter completion: Callback with current permission status.
    func askForPermission(completion: @escaping PermissionsKitResponse)
}
