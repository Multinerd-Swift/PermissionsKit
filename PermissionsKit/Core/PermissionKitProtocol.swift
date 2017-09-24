import Foundation

public typealias PermissionKitResponse = (PermissionKitStatus) -> Void

public protocol PermissionKitProtocol: class {

    /// The permission's identifier.
    var identifier: String { get }

    /// Used to determine the permissions current status.
    ///
    /// - Parameter completion: Callback with current permission status.
    func status(completion: @escaping PermissionKitResponse)

    /// Use this method to automatically manage the request for a permission.
    /// The behaviour is based on the PermissionKitConfiguration set during the initialization phase.
    ///
    /// - Parameter completion: Callback with current permission status.
    func manage(completion: @escaping PermissionKitResponse)

    /// Use this method to manually manage the request for a permission.
    /// This will burn your only chance for the system to prompt for permissions.
    ///
    /// - Parameter completion: Callback with current permission status.
    func askForPermission(completion: @escaping PermissionKitResponse)
}
