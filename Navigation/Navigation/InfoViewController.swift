
import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        makeAlertButton()
    }

    private func makeAlertButton() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        button.layer.cornerRadius = 10
        button.center = view.center
        button.backgroundColor = .systemBlue
        button.setTitle("BarButton", for: .normal)
        button.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        view.addSubview(button)
    }
    @objc private func tapAction() {
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
}
