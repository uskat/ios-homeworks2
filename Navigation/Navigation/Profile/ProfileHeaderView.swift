
import UIKit

class ProfileHeaderView: UIView {
    let sizeOfImage: CGFloat = 120
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    var buttonYPosition: CGFloat = 0
    var statusText = "Waiting for something....."
    
    var status = UITextView()
    var editStatus = UITextField()
    var buttonAccept = UIButton(type: .system)
    
    func settings() {
        backgroundColor = .lightGray
        layer.cornerRadius = 4
    }
    
    func showImage() -> UIImageView {
        let profileImage: UIImageView = {
            //x: отступ 16пт (техзадание)
            //y: отступ по расчетному значению высоты tabbar и navigationbar
            //w: h: размер фото профиля
            let imageView = UIImageView(frame: CGRect(
                            x: 16,
                            y: 16 + AppDelegate.topBarHeight,
                            width: 120,
                            height: 120))
            imageView.layer.cornerRadius = sizeOfImage / 2
            imageView.layer.borderWidth = 3
            imageView.layer.borderColor = UIColor.white.cgColor
            imageView.contentMode = .scaleAspectFill
            imageView.image = UIImage(named: "obiwan")
            imageView.clipsToBounds = true
            return imageView
        }()
        return profileImage
    }
    func showTitle() -> UITextView {
        let profileLabel: UITextView = {
            //x: отступ = размер фото и по 16пт с каждой стороны от него,
            //y: отступ по расчетному значению высоты tabbar и navigationbar + 27пт(техзадание)
            //w: ширина экрана - размер фото профиля - три отступа по 16пт с каждой из сторон
            //h: высота 30пт (техзадание)
            let label = UITextView(frame: CGRect(
                        origin: CGPoint(
                            x: 16 + sizeOfImage + 16,
                            y: 27 + CGFloat(AppDelegate.topBarHeight)),
                        size: CGSize(
                            width: (screenWidth - sizeOfImage - 16 * 3),
                            height: 30)))
            label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            label.isEditable = false
            label.text = "Obi Wan Kenobi"
            label.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
            return label
        }()
        return profileLabel
    }
    func showButton() -> UIButton {
        //x: отступ 16пт (техзадание)
        //y: отступ по расчетному значению высоты tabbar и navigationbar + размер фото профиля
        //   + два отступа по 16пт сверху и снизу от фото
        //w: ширина экрана - два отступа по 16пт с каждой из сторон
        //h: высота 50пт (техзадание)
        buttonYPosition = CGFloat(AppDelegate.topBarHeight) + 16 + sizeOfImage + 16
        let button = UIButton(frame: CGRect(
                            x: 16,
                            y: buttonYPosition,
                            width: screenWidth - 16 - 16,
                            height: 50))
        button.layer.cornerRadius = 4
        button.backgroundColor = .systemBlue
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Status is being recorded", for: .highlighted)
        button.setTitleColor(.white, for: .highlighted)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }
    @objc private func tapButton() {
        if let oldStatus = status.text {
            print("Прежний статус (до изменения) - \(oldStatus)")
        }
        status.text = statusText
        editStatus.text = ""
        if let newStatus = status.text {
            print("Новый статус - \(newStatus)")
        }
    }
    
    //ВОПРОС ПРЕПОДАВАТЕЛЮ:
    //Функция ниже отвечает за отображение тени под кнопкой
    //была взята полностью целиком из презентации к лекции. Изначально должно быть оформлено
    // с помощью sublayer. Однако, пришлось все заменить на layer и оставить бессмысленные"хвосты"
    // для return функции. Все работает именно так. Не могу все поменять на layer или на sublayer
    // так как в этом случае тени нет. Не могу понять что не так.
    //Функция settings в начале этого класса нужна тоже - без нее почему-то просвечивает белый
    // фон на месте скругления кнопки.
    //Хотя я тоже не совсем понимаю ее смысл в контексте задачи (отобразить тень).
    //Буду благодарен за подсказки
    
    func showShadowOfButton() -> CALayer {
        let sublayer = CALayer()
        //x: отступ 16пт (техзадание)
        //y: отступ по расчетному значению высоты tabbar и navigationbar + размер фото профиля
        //   + два отступа по 16пт сверху и снизу от фото (см.расчет выше в func showButton)
        //w: ширина экрана - два отступа по 16пт с каждой из сторон
        //h: высота 50пт (техзадание)
        layer.frame = CGRect(
                            x: 16,
                            y: buttonYPosition,
                            width: screenWidth - 16 - 16,
                            height: 50)
        layer.shadowOffset = CGSize(width: 4, height: 4)
        layer.shadowRadius = 4
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.7
        return sublayer
    }
    func showStatus() -> UITextView {
        let profileStatus: UITextView = {
            //x: отступ = размер фото и по 16пт с каждой стороны от него,
            //y: отступ по расчетному значению высоты tabbar и navigationbar + размер фото профиля
            //   + два отступа по 16пт сверху и снизу от фото
            //   - 64пт (отступ вверх от кнопки до данного поля) - 26пт (высота данного поля)
            //w: ширина экрана - размер фото профиля - три отступа по 16пт с каждой из сторон
            //h: высота 26пт (подобрано примерно по размеру шрифта)
            status = UITextView(frame: CGRect(
                        origin: CGPoint(
                            x: 16 + sizeOfImage + 16,
                            y: buttonYPosition - 64/*34*/ - 26),
                        size: CGSize(
                            width: (screenWidth - sizeOfImage - 16 * 3),
                            height: 26)))
            status.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            status.isEditable = false
            status.textColor = UIColor.gray
            status.text = statusText
            status.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
            return status
        }()
        return profileStatus
    }
    func editStatusField() -> UITextField {
        //x: отступ = размер фото и по 16пт с каждой стороны от него,
        //y: отступ по расчетному значению высоты tabbar и navigationbar + размер фото профиля
        //   + два отступа по 16пт сверху и снизу от фото
        //   - 64пт (отступ вверх от кнопки до поля Статуса)
        //   + 10пт отступ от поля Статус до данного поля(UITextField)
        //w: ширина экрана - размер фото профиля - три отступа по 16пт с каждой из сторон
        //h: высота 40пт (техзадание)
        editStatus = UITextField(frame: CGRect(
                            x: 16 + sizeOfImage + 16,
                            y: buttonYPosition - 64/*34*/ + 10,
                            width: (screenWidth - sizeOfImage - 16 * 3),
                            height: 40))
        editStatus.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        editStatus.backgroundColor = .white
        editStatus.layer.cornerRadius = 12
        editStatus.layer.borderWidth = 1
        editStatus.layer.borderColor = UIColor.black.cgColor
        editStatus.addTarget(self, action: #selector(beginToEditStatus), for: .editingDidBegin)
        editStatus.addTarget(self, action: #selector(changeStatusText), for: .editingChanged)
        editStatus.addTarget(self, action: #selector(endToEditStatus), for: .editingDidEnd)
        return editStatus
    }
    @objc private func beginToEditStatus() {
        buttonAccept.isHidden = false
    }
    @objc private func changeStatusText(_ textField: UITextField) {
        if let myText = textField.text {
            statusText = myText
        }
    }
    @objc private func endToEditStatus() {
        //buttonAccept.isHidden = true
    }
    func showAcceptStatusButton() -> UIButton {
        //x: ширина экрана - отступ 16пт (от края экрана справа) - отступ 5пт (от края поля UITextField, чтобы кнопка оказалась внутри него) - размер данной кнопки
        //y: отступ по расчетному значению высоты tabbar и navigationbar + размер фото профиля
        //   + два отступа по 16пт сверху и снизу от фото
        //   - 64пт (отступ вверх от кнопки до поля Статуса)
        //   + 15пт отступ от поля Статус до поля UITextField
        //w: ширина 30пт 
        //h: высота 30пт
        buttonAccept = UIButton(frame: CGRect(
                            x: screenWidth - 16 - 5 - 30,
                            y: buttonYPosition - 64 + 15,
                            width: 30,
                            height: 30))
        buttonAccept.layer.cornerRadius = 12
        buttonAccept.backgroundColor = .systemBlue
        buttonAccept.setImage(UIImage(systemName: "checkmark.rectangle.portrait"), for: .normal)
        buttonAccept.tintColor = .white
        buttonAccept.isHidden = true
        buttonAccept.addTarget(self, action: #selector(tapAcceptStatusButton), for: .touchUpInside)
        return buttonAccept
    }
    @objc private func tapAcceptStatusButton() {
        status.text = statusText
        editStatus.text = ""
        var perspective = CATransform3DIdentity
        perspective.m34 = 1 / -200
        buttonAccept.imageView!.layer.transform = perspective
        let rotate = CABasicAnimation(keyPath: "transform.rotation.y")
        rotate.fromValue = 0
        rotate.byValue = CGFloat.pi * 2
        rotate.duration = 2
        buttonAccept.imageView!.layer.add(rotate, forKey: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.buttonAccept.isHidden = true
        })
    }
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
