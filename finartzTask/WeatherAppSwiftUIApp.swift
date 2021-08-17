
import SwiftUI

//App in başladığı yer
@main
struct WeatherAppSwiftUIApp: App {
    
    var body: some Scene {
        WindowGroup {
            WeatherListScreen(coreDM: CoreDataManeger()).environmentObject(Store())
        }
    }
}
