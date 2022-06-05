
import UIKit
 
class InfoViewController: UIViewController {

//MARK: ==================================== INITs ====================================
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        showDefaultItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarUIView?.backgroundColor = .none
    }

    override func viewDidDisappear(_ animated: Bool) {
        checkOrientation()
    }

//MARK: ================================== ViewITEMs ==================================
    private let infoDefaultImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "darthvader")
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var infoButton: CustomButton = {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 4
        button.backgroundColor = .systemBlue
        button.setTitle("RUUUUUUN AWAAAAAY !!!", for: .normal)
        button.addTarget(self, action: #selector(tapInfoButton), for: .touchUpInside)
        return button
    }()

    @objc private func tapInfoButton() {
        let alert = UIAlertController(title: "О, нет! Все пропало...", message: "Свистать всех наверх!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Полундра!", style: .default) {
            _ in self.dismiss(animated: true)
            print("Ок")
        }
        let cancel = UIAlertAction(title: "Отбой! Ложная тревога", style: .destructive) {
            _ in print("Отмена")
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }

    private func showDefaultItems() {
        view.addSubview(infoButton)
        view.addSubview(infoDefaultImage)
    
        NSLayoutConstraint.activate([
            infoDefaultImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            infoDefaultImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            infoDefaultImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            infoDefaultImage.bottomAnchor.constraint(equalTo: infoButton.topAnchor, constant: -8),

            infoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            infoButton.widthAnchor.constraint(equalToConstant: screenWidth),
            infoButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
