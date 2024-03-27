//
//  ScenicSpotDetailView.swift
//  finalTourGuideSQL
//
//  Created by KENK on 2024/3/26.
//

import SwiftUI

struct ScenicSpotDetailView: View {
    var scenicSpot: ScenicSpot

    var body: some View {
        ScrollView {
            VStack {
                AsyncImageView(urlString: scenicSpot.imageUrl)
                    .frame(height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding()
                
                Text(scenicSpot.title)
                    .font(.largeTitle)
                    .padding([.bottom, .top], 4)

                Text(scenicSpot.description)
                    .font(.body)
                    //避免文本超出左右两边
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
            }
        }
        .navigationTitle(scenicSpot.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}



#Preview {
    ScenicSpotDetailView(scenicSpot: ScenicSpot(id: 1, title: "裕民", description: "提及新疆，无论是四季旖旎的喀那斯美景，还是如梦如幻的伊犁那拉提风情，想必很多人都不陌生。但说起巴尔鲁克山，或许并没有多少人知道。 但是，那首在中华大地传唱了20多年的军旅歌曲《小白杨》，却几乎为每一个中国人所熟知。而高高耸立在中哈边境巴尔鲁克山上的小白杨哨所，就是这首歌曲的诞生地。巴尔鲁克山，就像其名字的寓意：美丽，富饶。她不仅浓缩了天山和阿尔泰山的精华，有着如诗如画般的丘陵草原和浓缩的高山、峡谷、森林、草甸，还有着许多不为世人所知的壮美故事，也因此吸引了众多的户外爱好者。巴尔鲁克山位于裕民县中南部，横贯东西的巴尔鲁克山脉，是裕民县的标志性山脉。如果把中国的版图喻为雄鸡，它就是鸡顶端向下弯曲的一片漂亮的羽翎。巴尔鲁克山整个山脉呈中高山型，由于山体多次上升，构成明显的垂直分带。最高峰是塔普汗峰，海拔3252米。巴尔鲁克山北坡山峦起伏明显，降水丰富，灌木、草原型植被生长茂盛，是优良的夏牧场。低山带的坡度平缓，宽谷和丘状山连绵起伏，土质松软肥沃，降水较丰富，草木繁茂，呈山地草原景观，绝大部分是优美的天然牧场。裕民县大大小小共有16条河流，均发源于巴尔鲁克山区。", imageUrl: "https://s2.loli.net/2024/03/26/7xJZjXgoFzeMA8T.jpg"))
}
