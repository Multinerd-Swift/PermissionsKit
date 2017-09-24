import PermissionsKit
import UIKit

class PermissionKitCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!

    var viewModel: PermissionKitCellVM? {
        didSet {
            self.titleLbl.text = viewModel?.title

            self.viewModel?.permission.status(completion: { (status) in

                self.updateUI(status)

            })
        }
    }

    var clicked: Bool = false {
        didSet {
            if clicked, (viewModel?.permission != nil) {

                self.managePermission()

            }
        }
    }

    private func managePermission() {

        viewModel?.permission.manage(completion: { (status) in

            self.updateUI(status)

        })
    }

    private func updateUI(_ status: PermissionKitStatus) {

        DispatchQueue.main.async {
            switch status {
                case .authorized:
                    self.statusLbl.text = "✅"
                case .denied:
                    self.statusLbl.text = "⛔️"
                case .notAvailable:
                    self.statusLbl.text = "📵"
                case .notDetermined:
                    self.statusLbl.text = "⁉️"
            }

            self.setSelected(false, animated: false)
        }
    }
}

class PermissionKitCellVMServiceProgrammatically {

    static private var permissions = [ [ "label": "Bluetooth" ], [ "label": "Camera" ], [ "label": "CloudKit" ], [ "label": "Contacts" ], [ "label": "Events" ], [ "label": "Health" ], [ "label": "Media Library" ], [ "label": "Microphone" ], [ "label": "Motion" ], [ "label": "Notifications" ], [ "label": "Photos" ], [ "label": "Reminders" ], [ "label": "Speech" ], [ "label": "Location - Always" ], [ "label": "Location - When In Use" ] ]

    static var permissionCount: Int {
        return self.permissions.count
    }

    static func buildVM(index: Int) -> PermissionKitCellVM {

        let data = permissions[index]

        let configuration = PermissionKitConfigurations(frequency: .onceADay, presentInitialPopup: true, presentReEnablePopup: true)
        let initialPopupData = PermissionKitAlert(title: data["label"]!, message: "Enable \(data["label"]!) Permissions!", allowButtonTitle: "Allow 👍🏼", denyButtonTitle: "No! 👎🏼")

        let reenablePopupData = PermissionKitAlert(title: data["label"]!, message: "Enable \(data["label"]!) Permissions!", allowButtonTitle: "Allow 👍🏼", denyButtonTitle: "No! 👎🏼")

        let permission = getPermissionType(index: index, configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reenablePopupData)
        return PermissionKitCellVM(permission: permission!, title: data["label"]!)
    }

    static private func getPermissionType(index: Int, configuration: PermissionKitConfigurations, initialPopupData: PermissionKitAlert, reEnablePopupData: PermissionKitAlert) -> PermissionKitProtocol? {

        switch index {
            case 0: return PermissionKitBluetooth(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
            case 1: return PermissionKitCamera(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
            case 2: return PermissionKitCloudKit(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
            case 3:return PermissionKitContacts(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
            case 4:return PermissionKitEvents(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
            case 5:return PermissionKitHealth(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
            case 6:return PermissionKitMediaLibrary(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
            case 7:return PermissionKitMicrophone(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
            case 8:return PermissionKitMotion(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
            case 9:return PermissionKitNotifications(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
            case 10:return PermissionKitPhoto(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
            case 11:return PermissionKitReminders(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
            case 12:return PermissionKitSpeechRecognizer(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
            case 13:return PermissionKitLocationAlways(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
            case 14:return PermissionKitLocationWhenInUse(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
            default: return nil
        }
    }

}

class PermissionKitCellVM {

    private(set) var permission: PermissionKitProtocol

    private(set) var title: String

    init(permission: PermissionKitProtocol, title: String) {

        self.permission = permission
        self.title = title
    }
}
