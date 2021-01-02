//
//  Home.swift
//  VerticalCarousel
//
//  Created by Maxim Macari on 2/1/21.
//

import SwiftUI
import AVKit

struct Home: View {
    
    @State var index = 0
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var videos = [
        AVPlayer(url: URL(string: "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/360/Big_Buck_Bunny_360_10s_2MB.mp4")!),
        AVPlayer(url: URL(string: "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/360/Big_Buck_Bunny_360_10s_2MB.mp4")!),
        AVPlayer(url: URL(string: "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/360/Big_Buck_Bunny_360_10s_2MB.mp4")!),
        AVPlayer(url: URL(string: "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/360/Big_Buck_Bunny_360_10s_2MB.mp4")!),
        AVPlayer(url: URL(string: "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/360/Big_Buck_Bunny_360_10s_2MB.mp4")!)
        
    ]
    
    var body: some View {
        TabView(selection: $index) {
            ForEach(1..<videos.count, id: \.self) { i in
                
                Player(video: $videos[i])
                    .rotationEffect(.init(degrees: -90))
                    .frame(width: UIScreen.main.bounds.width)
                    .tag(i)
                
            }
            //when index changes, tab cahnges too...Pausing all other videos
            .onChange(of: index, perform: { value in
                
                for i in 0..<videos.count {
                    videos[i].pause()
                }
                
                videos[index].play()
            })
        }
        .rotationEffect(.init(degrees: 90))
        .frame(width: UIScreen.main.bounds.height - (edges!.top + edges!.bottom))
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .background(
            Color.black
                .ignoresSafeArea(.all, edges: .all)
        )
        
        //rotating views and changing width and height
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


//Building tiktok video player
struct Player: View {
    
    @Binding var video: AVPlayer
    
    var body: some View{
        VStack{
            VideoPlayer(player: video)
        }
    }
}
