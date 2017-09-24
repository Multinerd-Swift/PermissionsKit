import UIKit
import PermissionsKit

struct ExamplePermission {
    var permission: PermissionKitBase

    var title: String
}

class ViewController: UIViewController {

}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return PermissionKitCellVMServiceProgrammatically.permissionCount
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PermissionKitCell", for: indexPath) as? PermissionKitCell else {
            fatalError()
        }

        cell.viewModel = PermissionKitCellVMServiceProgrammatically.buildVM(index: indexPath.row)

        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return "Permissions configured programmatically"
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let cell = tableView.cellForRow(at: indexPath) as? PermissionKitCell else {
            fatalError()
        }

        cell.clicked = true
    }
}
