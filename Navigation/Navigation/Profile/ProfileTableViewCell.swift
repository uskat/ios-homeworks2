
import UIKit

class ProfileTableViewCell: UITableViewCell {

    private let postView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        return $0
    }(UIView())
    
    private let postName: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        //$0.backgroundColor = .lightGray
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        //$0.text = "Мама мыла раму, Вова курит Приму."
        $0.numberOfLines = 2
        return $0
    }(UILabel())
    
    private let postDescription: UITextView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        //$0.backgroundColor = .white
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .systemGray
        $0.isEditable = false
        //$0.text = "Быть или не быть - вот в чём вопрос! Во поле березка стояла, во поле кудрявая стояла. Люли-люли - стояла! Нас орда! А нас рать! Однажды в студёную зимнюю пору, я из лесу вышел - был сильный мороз. Смотрю поднимается медленно в гору, лошадка везущая хворосту воз. Откуда дровишки - Из лесу, вестимо. Отец, слышишь, рубит, а я отвожу."
        //$0.numberOfLines = 2
        $0.isScrollEnabled = false
        return $0
    }(UITextView())

    private let postImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    private let likes: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .black
        //$0.backgroundColor = .lightGray
        //$0.text = "Likes: 111"
        $0.textAlignment = .left
        //$0.nu
        return $0
    }(UILabel())
    
    private let views: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .black
        //$0.backgroundColor = .lightGray
        //$0.text = "Viewes: 555"
        $0.textAlignment = .right
        return $0
    }(UILabel())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        show()
        //customizecell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(_ post: Post) {
        postImage.image = post.imageName
        postName.text = post.author
        postDescription.text = post.description
        likes.text = "Likes: " + String(post.likes)
        views.text = "Views: " + String(post.views)
    }
    
    //func customizecell() {
        //postView.layer.cornerRadius = 10
        //postView.layer.borderWidth = 10
        //postView.layer.borderColor = UIColor.purple.cgColor
    //}
    private func show() {
        [postView, postName, postDescription, postImage, likes, views].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            postView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            postView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            postView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -0),
            postView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -0)
        ])
        
        NSLayoutConstraint.activate([
            postName.topAnchor.constraint(equalTo: postView.topAnchor, constant: 16),
            postName.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: 16),
            postName.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: -16),
            //postName.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            postImage.topAnchor.constraint(equalTo: postName.bottomAnchor, constant: 12),
            postImage.leadingAnchor.constraint(equalTo: postView.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: postView.trailingAnchor),
            postImage.heightAnchor.constraint(equalToConstant: screenWidth)
        ])
        
        NSLayoutConstraint.activate([
            postDescription.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 16),
            postDescription.leadingAnchor.constraint(equalTo: postName.leadingAnchor),
            postDescription.trailingAnchor.constraint(equalTo: postName.trailingAnchor),
            //postDescription.heightAnchor.constraint(equalToConstant: )
        ])
        
        NSLayoutConstraint.activate([
            likes.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 16),
            likes.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: 16),
            likes.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: -16),
            likes.bottomAnchor.constraint(equalTo: postView.bottomAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            views.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 16),
            views.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: 16),
            views.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: -16),
            views.bottomAnchor.constraint(equalTo: postView.bottomAnchor, constant: -16)
        ])
    }
    
}
