//
//  ContentView.swift
//  finalTourGuideSQL
//
//  Created by KENK on 2024/3/26.
//

import SwiftUI

struct ContentView: View {
    @State private var scenicSpots: [ScenicSpot] = []
    private var dbManager = DatabaseManager()
    
    var body: some View {
        
        TabView{
            NavigationView {
                List(scenicSpots) { spot in
                    NavigationLink(destination: ScenicSpotDetailView(scenicSpot: spot)) {
                        VStack(alignment: .leading) {
                            AsyncImageView(urlString: spot.imageUrl)
                                .frame(width: 300, height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.bottom, 5)
                            
                            Text(spot.title)
                                .font(.headline)
                            Text(spot.description)
                                .font(.subheadline)
                                .lineLimit(3)
                                .padding(.bottom, 5)
                        }
                        .padding()
                    }
                }
                .navigationTitle("景点介绍")
            }
            .tabItem {
                Image(systemName: "photo.on.rectangle.angled")
                Text("首页")
            }
            WeatherView()
            .tabItem {
                Image(systemName: "cloud.sun")
                Text("天气")
            }
            ShoppingView()
            .tabItem {
                Image(systemName: "cart")
                Text("门票购买")
            }
            SQLToggleView()
            .tabItem {
                Image(systemName: "person")
                Text("我的")
            }
            TicketView(ticket: Ticket(type: "成人票", price: "¥100"))
            .tabItem {
                Image(systemName: "doc.text")
                Text("票据")
            }
        }
        .onAppear {
            scenicSpots = dbManager.fetchAllScenicSpots()
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


