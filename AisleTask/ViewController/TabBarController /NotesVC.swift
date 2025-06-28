import UIKit

class NotesVC: UIViewController {
    
    var params = [String: Any]()
    var invitesList: [InviteProfile] = []
    var likesList: [LikeProfile] = []
    let indicatorView = UIActivityIndicatorView()


    
    var NoteTitleLbl: UILabel = {
        let NoteTitleLbl = UILabel()
        NoteTitleLbl.text = "Notes"
        NoteTitleLbl.textAlignment = .center
        NoteTitleLbl.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        NoteTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        return NoteTitleLbl
    }()

    var SubTitleLbl: UILabel = {
        let SubTitleLbl = UILabel()
        SubTitleLbl.text = "Personal messages to you"
        SubTitleLbl.textAlignment = .center
        SubTitleLbl.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        SubTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        return SubTitleLbl
    }()
    
    var profileCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 100, height: 100)
            layout.minimumLineSpacing = 10
        
        let profileCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            profileCollectionView.layer.cornerRadius = 20
            profileCollectionView.translatesAutoresizingMaskIntoConstraints = false
            return profileCollectionView
    }()
    
    var InterestedTitleLbl:UILabel = {
        let InterestedTitleLbl = UILabel()
        InterestedTitleLbl.text = "Interested In You"
        InterestedTitleLbl.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        InterestedTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        return InterestedTitleLbl
    }()
    
    var PremiumTitleLbl:UILabel = {
        let PremiumTitleLbl = UILabel()
        PremiumTitleLbl.text = "Premium members can\nview all their likes at once"
        PremiumTitleLbl.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        PremiumTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        PremiumTitleLbl.textColor = .gray
        PremiumTitleLbl.numberOfLines = 0
        return PremiumTitleLbl
    }()
    var UpgradeBtn:UIButton = {
        let UpgradeBtn = UIButton()
        UpgradeBtn.setTitle("Upgrade", for: .normal)
        UpgradeBtn.setTitleColor(.black, for: .normal)
        UpgradeBtn.backgroundColor = UIColor(named: "GoldenYellow")
        UpgradeBtn.translatesAutoresizingMaskIntoConstraints = false
        UpgradeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        UpgradeBtn.layer.cornerRadius = 25
        
        return UpgradeBtn
    }()
    
    var ProfileListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 100, height: 100)
            layout.minimumLineSpacing = 10
        let ProfileListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        ProfileListCollectionView.layer.cornerRadius = 20
        ProfileListCollectionView.translatesAutoresizingMaskIntoConstraints = false
            return ProfileListCollectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupConstrants()
        apiHandler()
    }
    
    func SetupConstrants() {
        
        profileCollectionView.tag = 1
        ProfileListCollectionView.tag = 2
        
        view.addSubview(NoteTitleLbl)
        view.addSubview(SubTitleLbl)
        view.addSubview(profileCollectionView)
        view.addSubview(InterestedTitleLbl)
        view.addSubview(PremiumTitleLbl)
        view.addSubview(UpgradeBtn)
        view.addSubview(ProfileListCollectionView)


        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        profileCollectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: "ProfileCollectionViewCell")
        
        ProfileListCollectionView.delegate = self
        ProfileListCollectionView.dataSource = self
        ProfileListCollectionView.register(ProfileListCollectionViewCell.self, forCellWithReuseIdentifier: "ProfileListCollectionViewCell")

                
        NSLayoutConstraint.activate([
            NoteTitleLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            NoteTitleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            NoteTitleLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            SubTitleLbl.topAnchor.constraint(equalTo: NoteTitleLbl.bottomAnchor, constant: 10),
            SubTitleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            SubTitleLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            profileCollectionView.topAnchor.constraint(equalTo: SubTitleLbl.bottomAnchor, constant: 10),
            profileCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            profileCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            profileCollectionView.widthAnchor.constraint(equalToConstant: 250),
            profileCollectionView.heightAnchor.constraint(equalToConstant: 300),
            
            InterestedTitleLbl.topAnchor.constraint(equalTo: profileCollectionView.bottomAnchor, constant: 10),
            InterestedTitleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            InterestedTitleLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            PremiumTitleLbl.topAnchor.constraint(equalTo: InterestedTitleLbl.bottomAnchor, constant: 5),
            PremiumTitleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            PremiumTitleLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            UpgradeBtn.topAnchor.constraint(equalTo: InterestedTitleLbl.bottomAnchor, constant: 1),
            UpgradeBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            UpgradeBtn.widthAnchor.constraint(equalToConstant: 120),
            UpgradeBtn.heightAnchor.constraint(equalToConstant: 50),
            
            ProfileListCollectionView.topAnchor.constraint(equalTo: PremiumTitleLbl.bottomAnchor, constant: 20),
            ProfileListCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ProfileListCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ProfileListCollectionView.widthAnchor.constraint(equalToConstant: 130),
            ProfileListCollectionView.heightAnchor.constraint(equalToConstant: 220),
            
            
            
        ])
    }

    func apiHandler() {
        
        showActivityIndicator(indicatorView)
        params = ["Authorization": "Bearer \(strstore.strToken)"]
        APIHandler.shared.GetAPI(Url: "\(WebAPI().BASEURL)\(WebAPI().NotesAPI)", Header: params) { (result: Result<NotesListModel, Error>) in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let response):
                    print("API Success: \(response)")
                    hideIndicatorLoader(indicatorView)
                    if let profiles = response.invites?.profiles {
                        self.invitesList = profiles
                        self.profileCollectionView.reloadData()
                    }
                    if let likesProfiles = response.likes?.profiles {
                        self.likesList = likesProfiles
                        self.ProfileListCollectionView.reloadData()
                                    }
                case .failure(let error):
                    print("Decoding Error: \(error.localizedDescription)")
                    hideIndicatorLoader(indicatorView)

                }
            }
        }

        }
    }


extension NotesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 1:
            return invitesList.count
        case 2:
            return likesList.count
            
        default:
            return Int()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.tag {
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as? ProfileCollectionViewCell else {
                return UICollectionViewCell()
            }
            let profile = invitesList[indexPath.item]
            let imageUrl = profile.photos?.first?.photo ?? "No Image"
            let name = profile.general_information?.first_name ?? "No Name"
            let age = profile.general_information?.age ?? 0
            
            if let url = URL(string: imageUrl) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url), let img = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.configure(with: img, name: name, age: age)
                        }
                    }
                }
            }
            return cell

        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileListCollectionViewCell", for: indexPath) as? ProfileListCollectionViewCell else {
                return UICollectionViewCell()
            }
            let likeProfile = likesList[indexPath.item]
                    let name = likeProfile.first_name ?? "No Name"
                    let imageUrl = likeProfile.avatar ?? ""
                    
                    if let url = URL(string: imageUrl) {
                        DispatchQueue.global().async {
                            if let data = try? Data(contentsOf: url), let img = UIImage(data: data) {
                                DispatchQueue.main.async {
                                    cell.configure(with: img, name: name)
                                }
                            }
                        }
                    }
return cell
        default:
            return UICollectionViewCell()
        }
    
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 1:
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)

        case 2:
            let spacing: CGFloat = 10
                    let totalSpacing = spacing * (2 - 1)
                    let itemWidth = (collectionView.frame.width - totalSpacing) / 2
                    let itemHeight = collectionView.frame.height
                    
                    return CGSize(width: itemWidth, height: itemHeight)
        default:
            return CGSize()
        }
    }
}

