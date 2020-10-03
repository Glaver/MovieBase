//
//  ContentView.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 5/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import SwiftUI

struct MovieScrollView: View {
    
    @ObservedObject var viewModel = MovieViewModel()
    @ObservedObject var ganresModel = GanreViewModel()
    
    var body: some View {
        VStack{
            Picker("", selection: $viewModel.indexOfMoviesList){
                Text("Now Playing").tag(0)
                Text("Popular").tag(1)
                Text("Upcoming").tag(2)
                Text("Top Rated").tag(3)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            NavigationView {
                VStack{
                    ScrollViewMovies(arrayDataFromAPI: viewModel.movies, ganresDictionary: ganresModel.dictionaryGanres)
                }.navigationBarTitle("Movies", displayMode: .inline)
            }
            
        }
    }
}

//UIColor.blue
struct ScrollViewMovies : View {
    var arrayDataFromAPI : [MovieModel]
    var ganresDictionary : GenresDictionary
    
    var body: some View {
        List(self.arrayDataFromAPI,  id: \.id){ item in
            NavigationLink(destination: MovieDetailView(movie: item)){
                SectionView(section: item, inputURLforImage: "https://image.tmdb.org/t/p/original" + item.posterPath!, ganresDictionary: self.ganresDictionary)
            }
        }
    }
}


struct SectionView: View {
    var section: MovieModel
    let inputURLforImage: String
    let ganresDictionary: GenresDictionary
    var body: some View {
        HStack{
            ImageView(withURL: inputURLforImage)
            VStack(alignment: .leading){
                Text(section.title)
                    .font(.system(size: 18))
                    .bold()
                    .frame(width: 230, height: 70, alignment: .center)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                Text(GanreViewModel.convertorGenresToString(ganresDict: ganresDictionary, genresOfMovie: section.genres))//GanreViewModel.convertorGenresToString(ganresDict: ganresDictionary, genresOfMovie: section.genreIds))
                Spacer()
                HStack{
                    Text(section.releaseDate.printFormattedDate(format: "MMM dd,yyyy"))
                       .foregroundColor(Color.blue)
                    Spacer()
                    Text(String(section.rating))
                        .font(Font.body.bold())
                        .frame(width: 40, height: 25)
                        .background(Color.yellow)
                        .cornerRadius(10)
                }
            }
        }
    }
}







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieScrollView()
    }
}


/*    init() {
    UISegmentedControl.appearance().selectedSegmentTintColor = .cyan
    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.cyan], for: .normal)
}*/


