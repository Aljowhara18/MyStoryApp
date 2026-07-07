
import Foundation
import Combine

class HomeViewModel: ObservableObject {
    let menuTitles = [
        NSLocalizedString("home_menu_choose_story", comment: "Home menu - choose story"),
        NSLocalizedString("home_menu_create_story", comment: "Home menu - create story")
    ]
}
