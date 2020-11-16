//
//  TaglineView.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 5/11/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import SwiftUI

struct TaglineView: View {
    var tagline: String?
    var body: some View {
        if tagline != "NO" {
            Text("\(tagline!)")
                .font(.system(.title, design: .rounded))
                .shadow(color: .black, radius: 5)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.white)
            //.frame(height: 100, alignment: .center)
        }
    }

    init(tagline: String) {
        self.tagline = tagline
    }
}

//struct TaglineView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaglineView()
//    }
//}
