import SwiftUI

struct AddCityScreen: View {
    
    @EnvironmentObject var store: Store
    @Environment(\.presentationMode) private var presentationMode
    @StateObject private var addWeatherVM = AddWeatherViewModel()
    let coreDM:CoreDataManeger
 
    @State private var weathers:[Weathers] = [Weathers]()
    private func populateWeathers(){
        weathers = coreDM.getAllWeathers()
    }
     
    
    var body: some View{
        
        VStack {
            VStack(spacing: 20) {
                TextField("Şehrin ismini giriniz.", text: $addWeatherVM.city )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Kaydet") {
                    // save weather in environment object
                  
                    
                    addWeatherVM.save { weather in
                       
                        store.addWeather(weather)
                     
                        
                        coreDM.saveWeather(city:weather.city,icon: weather.icon,sunriseTime: weather.sunrise,sunsetTime: weather.sunset,temperature: weather.temperature)
                    
                        presentationMode.wrappedValue.dismiss()
                       
                    }
                    
                }.padding(10)
                .frame(maxWidth: UIScreen.main.bounds.width/4)
                .foregroundColor(Color.white)
                .background(Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }.padding()
            .frame(maxWidth: .infinity, maxHeight: 200)
            .background(Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
         Spacer()
        }.padding()
        
        .navigationTitle("Şehir Ekle")
      
      
        
        
        .embedInNavigationView()
    }
}

struct AddCityScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddCityScreen(coreDM: CoreDataManeger()).environmentObject(Store())
    }
}
