
import UIKit

class ProfileHeaderView: UIView {
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    private var statusText = "Waiting for something....."
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 140 / 2  //размер 140 (140/2 - радиус)
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "obiwan")
        imageView.clipsToBounds = true
        return imageView
    }()

    private let profileLabel: UITextView = {
        let label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.isEditable = false
        label.text = "Obi Wan Kenobi"
        label.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        return label
    }()

    private lazy var mainButton: CustomButton = {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 4
        button.backgroundColor = .systemBlue
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Status is being recorded", for: .highlighted)
        //button.setTitleColor(.systemGray, for: .highlighted)
        button.addTarget(self, action: #selector(tapMainButton), for: .touchUpInside)

        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        return button
    }()
    @objc private func tapMainButton() {
        if let oldStatus = profileStatus.text {
            print("Прежний статус (до изменения) - \(oldStatus)")
        }
        profileStatus.text = statusText
        if let newStatus = editStatus.text {
            print("Новый статус - \(newStatus)")
        }
        editStatus.text = ""
        rotateAndSleep(0) //прячем вспомогательную кнопку без анимации
    }
    
    private let profileStatus: UITextView = {
        let status = UITextView()
        status.translatesAutoresizingMaskIntoConstraints = false
        status.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        status.isEditable = false
        status.textColor = UIColor.darkGray
        status.text = "Waiting for something....."
        status.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        return status
    }()

    private lazy var editStatus: UITextField = {
        let status = UITextField()
        status.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        status.translatesAutoresizingMaskIntoConstraints = false
        status.backgroundColor = .white
        status.layer.cornerRadius = 12
        status.layer.borderWidth = 1
        status.layer.borderColor = UIColor.black.cgColor
        status.addTarget(self, action: #selector(beginToEditStatus), for: .allEditingEvents)
        status.addTarget(self, action: #selector(changeStatusText), for: .editingChanged)
        status.addTarget(self, action: #selector(endToEditStatus), for: .editingDidEnd)
        return status
    }()
    
    @objc private func beginToEditStatus() {
        buttonAccept.isHidden = false
    }
    @objc private func changeStatusText(_ textField: UITextField) {
        buttonAccept.isHidden = false
        if let myText = textField.text {
            statusText = myText
        }
    }
    @objc private func endToEditStatus() {
        rotateAndSleep(0) //прячем вспомогательную кнопку без анимации
    }

    private lazy var buttonAccept: CustomButton = {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 9
        button.backgroundColor = .systemBlue
        button.setImage(UIImage(systemName: "checkmark.rectangle.portrait"), for: .normal)
        button.tintColor = .white
        button.isHidden = true
        button.addTarget(self, action: #selector(tapAcceptStatusButton), for: .touchUpInside)
        return button
    }()
    @objc private func tapAcceptStatusButton() {
        profileStatus.text = statusText
        editStatus.text = ""
        rotateAndSleep(1) //прячем вспомогательную кнопку с анимацией (после нажатия на неё)
    }
    private func rotateAndSleep(_ key: Int) {
        if key == 1 { //анимация на вспомогательной кнопке
            var perspective = CATransform3DIdentity
            perspective.m34 = 1 / -200
            buttonAccept.imageView!.layer.transform = perspective
            let rotate = CABasicAnimation(keyPath: "transform.rotation.y")
            rotate.fromValue = 0
            rotate.byValue = CGFloat.pi * 2
            rotate.duration = 2
            buttonAccept.imageView!.layer.add(rotate, forKey: nil)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.buttonAccept.isHidden = true
        })
    }
    
    func showProfileHeaderView() {
        [profileImage, profileLabel, mainButton, profileStatus, editStatus, buttonAccept].forEach { self.addSubview($0) }
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            profileImage.widthAnchor.constraint(equalToConstant: 140),
            profileImage.heightAnchor.constraint(equalToConstant: 140)
        ])
        
        NSLayoutConstraint.activate([
            profileLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            profileLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 16),
            profileLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            profileLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            mainButton.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 16),
            mainButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            mainButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            mainButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            profileStatus.bottomAnchor.constraint(equalTo: mainButton.topAnchor, constant: -56),
            profileStatus.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 16),
            profileStatus.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            profileStatus.heightAnchor.constraint(equalToConstant: 26)
        ])
        
        NSLayoutConstraint.activate([
            editStatus.bottomAnchor.constraint(equalTo: mainButton.topAnchor, constant: -8),
            editStatus.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 16),
            editStatus.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            editStatus.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            buttonAccept.topAnchor.constraint(equalTo: editStatus.topAnchor, constant: 5),
            buttonAccept.trailingAnchor.constraint(equalTo: editStatus.trailingAnchor, constant: -5),
            buttonAccept.widthAnchor.constraint(equalToConstant: 30),
            buttonAccept.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
