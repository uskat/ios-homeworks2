
import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    
//MARK: ==================================== INITs ====================================
    override init(frame: CGRect) {
        super.init(frame: frame)
        showImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//MARK: ================================== ViewITEMs ==================================
    private let imageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    func showImageView() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    
//MARK: =================================== METHODs ===================================
    func setupCell(_ photo: Photo) {
        imageView.image = photo.imageName
    }

}
