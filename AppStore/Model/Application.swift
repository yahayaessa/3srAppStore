
import Foundation

struct Application: Hashable, Identifiable, Codable {
    var id: Int
    var display_name: String
    var description: String?
    var version: String
    var support_duplicate: Int
    var ipa_size: String
    var icon_file_url: String?
    var temp_sign_url: String
}

