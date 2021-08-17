import SwiftUI

enum Sheets: Identifiable {
    
    var id: UUID {
        return UUID()
    }
    
    case addNewCity

}

struct WeatherListScreen: View {

    @EnvironmentObject var store: Store
    @State private var activeSheet: Sheets?
  
    let coreDM : CoreDataManeger
    @State private var weatherCity:String=""
    @State private var weathers:[Weathers] = [Weathers]()
    private func populateWeathers(){
        weathers = coreDM.getAllWeathers()
    }
    let date = Date()
    
    
    var body: some View {
        List{
            
        
                
            ForEach(weathers, id: \.self) { weather in
                NavigationLink(destination:CountryDetail(countryName: weather.city ?? "",sunriseTime: weather.sunriseTime ?? date,sunsetTime: weather.sunsetTime ?? date,temperature: weather.temperature,icon: weather.icon ?? "")){
                    WeatherCell(weather: weather)
                }
                
            }.onDelete(perform:deleteCountry)
            
            
            
        }
       
        
        
        .listStyle(PlainListStyle())
        
        .sheet(item: $activeSheet, content: { (item) in
            switch item {
                case .addNewCity:
                    AddCityScreen(coreDM: CoreDataManeger()).environmentObject(store)
               
            }
        })
        
        .navigationBarItems(leading: Button(action: {
           
        }) {
            
        }, trailing: Button(action: {
            activeSheet = .addNewCity
        }, label: {
            Image(systemName: "plus")
        }))
        .navigationTitle("Şehirler")
        .onAppear(perform: { 
            populateWeathers()
        })
        .onDisappear(){
            print("şimdi çalıştı")
        }
        
       
       
       
     .embedInNavigationView().accentColor(.orange)
       
     
    }
    func deleteCountry(at offsets:IndexSet){
        self.store.weatherList.remove(atOffsets:offsets)
        offsets.forEach{ index in
            let weather = weathers[index]
            coreDM.deleteWeather(weather: weather)
            weathers = coreDM.getAllWeathers()
            
        }
    }
}


struct WeatherListScreen_Previews: PreviewProvider {
    static var previews: some View {
        WeatherListScreen(coreDM: CoreDataManeger()).environmentObject(Store())
    }
}

struct CountryDetail:View {
    
    
    var countryName:String
    var sunriseTime:Date
    var sunsetTime:Date
    var temperature :Double
    var icon:String
   
    var body: some View{
        
   
        
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue,.white]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
            VStack(alignment: HorizontalAlignment.center, spacing: 30){
               
                Text(countryName).font(.system(size: 32,weight: .medium,design: .default))
                    .foregroundColor(.white)
           URLImage(url: Constants.Urls.weatherUrlAsStringByIcon(icon: icon))  .frame(width: 80, height: 80)
                    
                HStack{
                    Text("\(Int(temperature)) C°").font(.system(size: 70,weight: .medium)).foregroundColor(.white)
                    
               
                }
               
              
                HStack{
                   Text(sunriseTime.formatAsString()).font(.system(size: 40,weight: .medium)).foregroundColor(.white)
                    Image(systemName: "sunrise.fill").renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                       .frame(width:150,height: 150)
                }
               
                HStack{
                   
                    Text(sunsetTime.formatAsString()).font(.system(size: 40,weight: .medium)).foregroundColor(.white)
                    Image(systemName: "sunset.fill").renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:150,height: 150)

                    
                }
                
                Spacer()
                
            }
        }
    }
}

struct WeatherCell: View {
    
    let weather: Weathers
   

   
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 15) {
                Text(weather.city!)
                    .fontWeight(.bold)
           
            }
            Spacer()
          
            Text("\(Int(weather.temperature)) C")
                
                .frame(width: 50, height: 50)
        
        }
        .padding()
        .background(Color(#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
    }
}
