
import UIKit

public struct Post {
    let author: String      //автор публикации
    var description: String?//текст публикации
    let imageName: UIImage  //имя картинки из коллекции
    var likes: Int          //количество лайков у публикации
    var views: Int          //количество просмотров публикации

    static func addPosts() -> [Post] {
        var post = [Post]()
        
        post.append(Post(author: "Chupa-Chups", description: "тру-ля-ля", imageName: UIImage(named: "post0")!, likes: 100, views: 300))
        post.append(Post(author: "Carbofos", description: "Быть или не быть - вот в чём вопрос! Во поле березка стояла, во поле кудрявая стояла. Люли-люли - стояла! Нас орда! А нас рать! Однажды в студёную зимнюю пору, я из лесу вышел - был сильный мороз. Смотрю поднимается медленно в гору, лошадка везущая хворосту воз. Откуда дровишки - Из лесу, вестимо. Отец, слышишь, рубит, а я отвожу.", imageName: UIImage(named: "post1")!, likes: 110, views: 400))
        post.append(Post(author: " Jean-Paul Belmondo", description: "тру-ля-ля", imageName: UIImage(named: "post2")!, likes: 120, views: 500))
        post.append(Post(author: "Donald Trump", imageName: UIImage(named: "post3")!, likes: 130, views: 600))
        post.append(Post(author: "T-1000", description: "Быть или не быть - вот в чём вопрос! Во поле березка стояла, во поле кудрявая стояла. Люли-люли - стояла! Нас орда! А нас рать! Однажды в студёную зимнюю пору, я из лесу вышел - был сильный мороз. Смотрю поднимается медленно в гору, лошадка везущая хворосту воз. Откуда дровишки - Из лесу, вестимо. Отец, слышишь, рубит, а я отвожу. Быть или не быть - вот в чём вопрос! Во поле березка стояла, во поле кудрявая стояла. Люли-люли - стояла! Нас орда! А нас рать! Однажды в студёную зимнюю пору, я из лесу вышел - был сильный мороз. Смотрю поднимается медленно в гору, лошадка везущая хворосту воз. Откуда дровишки - Из лесу, вестимо. Отец, слышишь, рубит, а я отвожу.", imageName: UIImage(named: "post4")!, likes: 140, views: 700))
        
        return post
    }
}


/*        section.append(Post(author: "Chupa-Chups", description: "тру-ля-ля", imageName: UIImage(named: "post0")!, likes: 100, views: 300))
 section.append(Post(author: "Carbofos", description: "Быть или не быть - вот в чём вопрос! Во поле березка стояла, во поле кудрявая стояла. Люли-люли - стояла! Нас орда! А нас рать! Однажды в студёную зимнюю пору, я из лесу вышел - был сильный мороз. Смотрю поднимается медленно в гору, лошадка везущая хворосту воз. Откуда дровишки - Из лесу, вестимо. Отец, слышишь, рубит, а я отвожу.", imageName: UIImage(named: "post1")!, likes: 100, views: 400))
 section.append(Post(author: " Jean-Paul Belmondo", description: "тру-ля-ля", imageName: UIImage(named: "post2")!, likes: 100, views: 500))
 section.append(Post(author: "Donald Trump", imageName: UIImage(named: "post3")!, likes: 100, views: 600))
 section.append(Post(author: "T-1000", description: "Быть или не быть - вот в чём вопрос! Во поле березка стояла, во поле кудрявая стояла. Люли-люли - стояла! Нас орда! А нас рать! Однажды в студёную зимнюю пору, я из лесу вышел - был сильный мороз. Смотрю поднимается медленно в гору, лошадка везущая хворосту воз. Откуда дровишки - Из лесу, вестимо. Отец, слышишь, рубит, а я отвожу. Быть или не быть - вот в чём вопрос! Во поле березка стояла, во поле кудрявая стояла. Люли-люли - стояла! Нас орда! А нас рать! Однажды в студёную зимнюю пору, я из лесу вышел - был сильный мороз. Смотрю поднимается медленно в гору, лошадка везущая хворосту воз. Откуда дровишки - Из лесу, вестимо. Отец, слышишь, рубит, а я отвожу.", imageName: UIImage(named: "post4")!, likes: 100, views: 700))*/
