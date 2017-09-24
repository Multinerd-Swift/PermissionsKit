import UIKit

/// PermissionKitBase is a root class and each permission inherit from it.
/// Don't instantiate PermissionKitBase directly.
public class PermissionKitBase {

    var configuration: PermissionKitConfigurations = PermissionKitConfigurations(frequency: .always, presentInitialPopup: true, presentReEnablePopup: true)
    var initialPopupData: PermissionKitAlert = PermissionKitAlert()
    var reEnablePopupData: PermissionKitAlert = PermissionKitAlert()

    init(identifier: String) {

        let data = PermissionKitLocalizationManager(permission: identifier)
        self.initialPopupData = PermissionKitAlert(title: data.initialTitle, message: data.initialMessage, allowButtonTitle: data.initialAllowButtonTitle, denyButtonTitle: data.initialDenyButtonTitle)
        self.reEnablePopupData = PermissionKitAlert(title: data.reEnableTitle, message: data.reEnableMessage, allowButtonTitle: data.reEnableAllowButtonTitle, denyButtonTitle: data.reEnableDenyButtonTitle)
    }

    init(configuration: PermissionKitConfigurations? = nil, initialPopupData: PermissionKitAlert? = nil, reEnablePopupData: PermissionKitAlert? = nil) {

        self.configuration = configuration ?? self.configuration
        self.initialPopupData = initialPopupData ?? self.initialPopupData
        self.reEnablePopupData = reEnablePopupData ?? self.reEnablePopupData
    }

    open func manage(completion: @escaping PermissionKitResponse) {

        (self as? PermissionKitProtocol)?.status { status in
            self.managePermission(status: status, completion: completion)
        }
    }

    internal func managePermission(status: PermissionKitStatus, completion: @escaping PermissionKitResponse) {

        switch status {
            case .notAvailable: break
            case .notDetermined: self.manageInitialPopup(completion: completion)
            case .authorized: return completion(.authorized)
            case .denied:
                self.presentReEnablePopup()
                return completion(.denied)

        }
    }

}

extension PermissionKitBase {

    // MARK: *** Manage Initial Popup ***

    func manageInitialPopup(completion: @escaping PermissionKitResponse) {

        if self.configuration.presentInitialPopup {
            self.presentInitialPopup(title: self.initialPopupData.title, message: self.initialPopupData.message, allowButtonTitle: self.initialPopupData.allowButtonTitle, denyButtonTitle: self.initialPopupData.denyButtonTitle, completion: completion)
        } else {
            (self as? PermissionKitProtocol)?.askForPermission(completion: completion)
        }
    }

    private func presentInitialPopup(title: String, message: String, allowButtonTitle: String, denyButtonTitle: String, completion: @escaping PermissionKitResponse) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let allow = UIAlertAction(title: allowButtonTitle, style: .default) { _ in
            (self as? PermissionKitProtocol)?.askForPermission(completion: completion)
            alert.dismiss(animated: true, completion: nil)
        }

        let deny = UIAlertAction(title: denyButtonTitle, style: .cancel) { _ in
            completion(.denied)
            alert.dismiss(animated: true, completion: nil)
        }

        alert.addAction(deny)
        alert.addAction(allow)

        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }

            topController.present(alert, animated: true, completion: nil)
        }
    }

    // MARK: *** Manage Re-enable Popup ***

    func presentReEnablePopup() {

        guard let permission = self as? PermissionKitProtocol else {
            return
        }

        if self.configuration.canPresentReEnablePopup(permission: permission) {
            self.presentReEnablePopup(title: self.reEnablePopupData.title, message: self.reEnablePopupData.message, allowButtonTitle: self.reEnablePopupData.allowButtonTitle, denyButtonTitle: self.reEnablePopupData.denyButtonTitle)
        } else {
            print("[PermissionKit] for \(self) present re-enable not allowed")
        }
    }

    private func presentReEnablePopup(title: String, message: String, allowButtonTitle: String, denyButtonTitle: String) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let allow = UIAlertAction(title: allowButtonTitle, style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)

            guard let url = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }

            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }

        let deny = UIAlertAction(title: denyButtonTitle, style: .cancel) { _ in
            alert.dismiss(animated: true, completion: nil)
        }

        alert.addAction(deny)
        alert.addAction(allow)

        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }

            topController.present(alert, animated: true, completion: nil)
        }
    }

}
