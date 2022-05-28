
import UIKit

class LogInViewController: UIViewController {

    private let notification = NotificationCenter.default //уведомление для того чтобы отслеживать перекрытие клавиатурой UITextField
    
    private let scrollLoginView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        return $0
    }(UIScrollView())
    
    private let contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoginItems()
        //login.becomeFirstResponder()
    }
    
    override func viewWillLayoutSubviews() {
        checkOrientation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true //прячем NavigationBar
        notification.addObserver(self, selector: #selector(keyboardAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(keyboardDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc private func keyboardAppear(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollLoginView.contentInset.bottom = keyboardSize.height + 70
            scrollLoginView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    @objc private func keyboardDisappear() {
        scrollLoginView.contentInset = .zero
        scrollLoginView.verticalScrollIndicatorInsets = .zero
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        notification.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private let logoItem: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "logo")
        return $0
    }(UIImageView())
    
    private let stackLogin: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 0.5
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.backgroundColor = .lightGray
        $0.clipsToBounds = true
        return $0
    }(UIStackView())

    private lazy var login: UITextField = {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.translatesAutoresizingMaskIntoConstraints = false
        //$0.borderStyle = .roundedRect
        $0.placeholder = "Login"
        $0.tag = 1
        $0.delegate = self
        $0.textColor = .black
        $0.tintColor = UIColor.AccentColor.normal
        $0.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        $0.autocapitalizationType = .none
        $0.backgroundColor = .systemGray6
        //$0.becomeFirstResponder()
        return $0
    }(UITextField())
    
    private lazy var loginAlert: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = ""
        $0.textColor = .systemRed
        $0.textAlignment = .right
        $0.font = UIFont.systemFont(ofSize: 13, weight: .light)
        return $0
    }(UILabel())
    
    private lazy var pass: UITextField = {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.translatesAutoresizingMaskIntoConstraints = false
        //$0.borderStyle = .roundedRect
        $0.placeholder = "Password"
        $0.tag = 2
        $0.delegate = self
        $0.textColor = .black
        $0.tintColor = UIColor.AccentColor.normal
        $0.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        $0.backgroundColor = .systemGray6
        $0.isSecureTextEntry = true
        return $0
    }(UITextField())
    
    private lazy var passAlert: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = ""
        $0.textColor = .systemRed
        $0.textAlignment = .right
        $0.font = UIFont.systemFont(ofSize: 13, weight: .light)
        return $0
    }(UILabel())

    private lazy var loginButton: CustomButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 10
        $0.backgroundColor = UIColor.AccentColor.normal
        $0.setTitle("Log in", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        //$0.setTitle("Log in...", for: .highlighted)
        //$0.setTitleColor(.gray, for: .highlighted)
        //$0.setTitle("Log in", for: .selected)
        //$0.setTitleColor(.gray, for: .selected)
        $0.addTarget(self, action: #selector(tapLoginButton), for: .touchUpInside)
        $0.layer.shadowOffset = CGSize(width: 4, height: 4)
        $0.layer.shadowRadius = 4
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.7
        return $0
    }(CustomButton())
    
    @objc private func tapLoginButton() {
        print("_______________")
        statusEntry = true
        checkInputedData(login, loginAlert)
        print("login status \(statusEntry)")
        checkInputedData(pass, passAlert)
        print("pass status \(statusEntry)")
        if statusEntry {
            if checkLoginPass(login, pass) {
                let profileViewController = ProfileViewController()
                navigationController?.pushViewController(profileViewController, animated: true)
                login.text = ""
                pass.text = ""
            } else {
                alertMessageOnTextField(passAlert, "Incorrect login or pass")
                shakeMeBaby(login)
                shakeMeBaby(pass)
            }
        }
    }
    
    func showLoginItems() {
        view.addSubview(scrollLoginView)
        
        NSLayoutConstraint.activate([
            scrollLoginView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollLoginView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollLoginView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollLoginView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        scrollLoginView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollLoginView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollLoginView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollLoginView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollLoginView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollLoginView.widthAnchor)
        ])
        
        [logoItem, stackLogin, loginButton].forEach({ contentView.addSubview($0) })
        [login, pass].forEach({ stackLogin.addArrangedSubview($0) })
        [loginAlert, passAlert].forEach({ contentView.addSubview($0) })
        
        NSLayoutConstraint.activate([
            logoItem.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 120),
            logoItem.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoItem.widthAnchor.constraint(equalToConstant: 100),
            logoItem.heightAnchor.constraint(equalToConstant: 100),

            stackLogin.topAnchor.constraint(equalTo: logoItem.bottomAnchor, constant: 120),
            stackLogin.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackLogin.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackLogin.heightAnchor.constraint(equalToConstant: 100),

            loginButton.topAnchor.constraint(equalTo: stackLogin.bottomAnchor, constant: 16),
            loginButton.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            loginAlert.centerYAnchor.constraint(equalTo: login.centerYAnchor),
            loginAlert.trailingAnchor.constraint(equalTo: login.trailingAnchor, constant: -5),
            loginAlert.widthAnchor.constraint(equalToConstant: 220),
            
            passAlert.centerYAnchor.constraint(equalTo: pass.centerYAnchor),
            passAlert.trailingAnchor.constraint(equalTo: pass.trailingAnchor, constant: -5),
            passAlert.widthAnchor.constraint(equalToConstant: 220)
        ])
    }
}

//MARK: код используется для обработки HEX цветов (вводятся в формате 0xFF или 0xFFFFFF)
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    convenience init(rgb: Int, a: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            a: a
        )
    }
    //How to use this ^^^ code:
    //let color = UIColor(red: 0xFF, green: 0xFF, blue: 0xFF, a: 0.5)
    //let color2 = UIColor(rgb: 0xFFFFFF, a: 0.5)
    
    struct AccentColor {
        static var normal: UIColor  { return UIColor(rgb: 0x4885CC, a: 1.0) }
        static var highlightened: UIColor { return UIColor(rgb: 0x4885CC, a: 0.8) } //не используется
        static var selected: UIColor { return UIColor(rgb: 0x4885CC, a: 0.8) }      //не используется
        static var disabled: UIColor { return UIColor(rgb: 0x4885CC, a: 0.8) }      //не используется
    }
}

//MARK: кастомная кнопка с изменением альфа-канала для разных её состояний
class CustomButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            if (isHighlighted) {
                alpha = 0.8
            } else {
                alpha = 1
            }
        }
    }
    override var isSelected: Bool {
        didSet {
            if (isSelected) {
                alpha = 0.8
            } else {
                alpha = 1
            }
        }
    }
}
//MARK: убираем клавиатуру по нажатию Enter (Return)
extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

//MARK: универсальный код для изменения цвета кнопки в зависимости от её состояния
/*extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
    }
}*/
