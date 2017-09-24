public struct PermissionKitAlert {

    var title: String!
    var message: String!
    var allowButtonTitle: String!
    var denyButtonTitle: String!

    public init(title: String = "", message: String = "", allowButtonTitle: String = "", denyButtonTitle: String = "") {

        self.title = title
        self.message = message
        self.allowButtonTitle = allowButtonTitle
        self.denyButtonTitle = denyButtonTitle
    }
}
