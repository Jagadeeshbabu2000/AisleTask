import Foundation

struct PhoneNumberModel: Codable {
    let status: Bool
}

struct OTPModel: Codable {
    let token: String
}

struct NotesListModel: Codable {
    let invites: InvitesData?
    let likes: LikesData?
}

struct InvitesData: Codable {
    let profiles: [InviteProfile]?
    let totalPages: Int?
    let pending_invitations_count: Int?
}

struct InviteProfile: Codable {
    let general_information: GeneralInformation?
    let approved_time: Double?
    let disapproved_time: Double?
    let photos: [PhotoData]?
}

struct GeneralInformation: Codable {
    let first_name: String?
    let age: Int?
    let gender: String?
    let date_of_birth: String?
    let location: LocationData?
}

struct LocationData: Codable {
    let summary: String?
    let full: String?
}

struct PhotoData: Codable {
    let photo: String?
    let photo_id: Int?
    let selected: Bool?
    let status: String?
}

struct LikesData: Codable {
    let profiles: [LikeProfile]?
    let can_see_profile: Bool?
    let likes_received_count: Int?
}

struct LikeProfile: Codable {
    let first_name: String?
    let avatar: String?
}
