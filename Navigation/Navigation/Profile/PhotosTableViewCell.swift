
import UIKit

class PhotosTableViewCell: UITableViewCell {

    let photosViewController = PhotosViewController()
    
    private let cellTitleName: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        $0.text = "Photos"
        return $0
    }(UILabel())
    
    //просто картинка стрелки
    private let arrowToCollection: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(systemName: "arrow.right")
        return $0
    }(UIImageView())
    
    private let fourPhotosView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.backgroundColor = .clear
        $0.spacing = 8
//        $0.backgroundColor = .white
        return $0
    }(UIStackView())
    
    //делаем выборку из первых 4х фото в коллекции для размещения в stackView
    lazy var arrayOfFirstFourPhotos: [UIImageView] = {
        lazy var array = [UIImageView]()
        for index in 0...3 {
            let onePhoto: UIImageView = {
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.contentMode = .scaleAspectFill
                $0.backgroundColor = .black
                $0.layer.cornerRadius = 6
                $0.clipsToBounds = true
                $0.image = photosViewController.photos[index].imageName
                return $0
            }(UIImageView())
            array.append(onePhoto)
        }
        return array
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        show()
        //customizecell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func show() {
        [cellTitleName, arrowToCollection, fourPhotosView].forEach({ contentView.addSubview($0) })
        arrayOfFirstFourPhotos.forEach({ fourPhotosView.addArrangedSubview($0) })
        
        let outSpace: CGFloat = 12  //внешние отступы от фото до края экрана
        let inSpace: CGFloat = 8    //внутренние отступы между фото
        let heightOfFourPhotos = (screenWidth - 2 * outSpace - 3 * inSpace) / 4
        
        NSLayoutConstraint.activate([
            cellTitleName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: outSpace),
            cellTitleName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: outSpace),
            cellTitleName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -outSpace),
            
            arrowToCollection.topAnchor.constraint(equalTo: contentView.topAnchor, constant: outSpace),
            arrowToCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -outSpace),
            arrowToCollection.centerYAnchor.constraint(equalTo: cellTitleName.centerYAnchor),
            
            fourPhotosView.topAnchor.constraint(equalTo: cellTitleName.bottomAnchor, constant: outSpace),
            fourPhotosView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: outSpace),
            fourPhotosView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -outSpace),
            fourPhotosView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -outSpace),
            fourPhotosView.heightAnchor.constraint(equalToConstant: heightOfFourPhotos)
        ])
    }
    
    
    /*override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }*/
}
