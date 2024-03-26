//
//  ContentView.swift
//  finalTourGuideSQL
//
//  Created by KENK on 2024/3/26.
//

import SwiftUI

struct ContentView: View {
    let scenicSpots = [
        ScenicSpot(id: 1, title: "长城", description: "中国长城是历史悠久的防御工事。", imageUrl: "https://s2.loli.net/2024/03/26/7xJZjXgoFzeMA8T.jpg"),
        ScenicSpot(id: 2, title: "黄山", description: "黄山，位于中国安徽省，著名的旅游景点。将阿里看见分开的时间减肥啦开始放假的快乐分到家了开发斯捷克洛夫大家发来打卡时间发了空间的六块腹肌啊看老师的距离开发的撒娇了咖啡就困了咖啡就大厦浪费的空间方老师看风景的苏里科夫多久啊法律的框架发生了咖啡就哦看见了", imageUrl: "https://s2.loli.net/2024/03/26/7xJZjXgoFzeMA8T.jpg")
    ]
    
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
            //放三个按钮在底部
            .tabItem {
                Image(systemName: "photo.on.rectangle.angled")
                Text("首页")
            }
            NavigationView {
                Text("这是第二个页面")
            }
            .tabItem {
                Image(systemName: "cloud.sun")
                Text("天气")
            }
            NavigationView {
                Text("这是第三个页面")
            }
            .tabItem {
                Image(systemName: "cart")
                Text("门票购买")
            }
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
