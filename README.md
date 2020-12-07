## MovieBase
Movies app written in Swift 5.3 using the TMDb API.

## Features:
- shows generated lists of movies and TV series.
- displays UI list's with posters, dates, genres and ratings.
- details for movies and TV series, the app show detailed information with trailers, posters and cast list.
- navigation by cast list and view detailed information and biography of person.
- in search tab you can find movies throughout the tMDB database

## Frameworks and technologies:
- MVVM architecture
- SwiftUI
- Combine
- Realm database
- SwiftLint
- Dependency Injection

## Screenshots
![alt text](https://github.com/Glaver/MovieBase/blob/master/PreviewPresentation/shot2.png?raw=true "Movie list")
![alt text](https://github.com/Glaver/MovieBase/blob/master/PreviewPresentation/shot1.png?raw=true "Detail shot Joker")

## Demo
![alt text](https://github.com/Glaver/MovieBase/blob/master/PreviewPresentation/dark1.gif?raw=true "Dark Mode, Movies and Details")
![alt text](https://github.com/Glaver/MovieBase/blob/master/PreviewPresentation/gridAndFilters.gif?raw=true "Grid vs Filtering")
![alt text](https://github.com/Glaver/MovieBase/blob/master/PreviewPresentation/search.gif?raw=true "TV Show vs Search")

## Setup
You'll need a few things before we get started. Make sure you have Xcode installed from the App Store or wherever. You can download all code what you need by Clone or download ZIP archive. 

Now that we have the code downloaded, we can run the app using Xcode 12. Make sure to open the `TheMovieDataBase1.1.xcworkspace` workspace, and not the `TheMovieDataBase1.1.xcodeproj` project.

Make sure to add your API key in folder `NetworkService` 
to swift file  `NetworkAPI.swift` 
line 13 `let apiKey: String = <your api key>` 

## Requirements:
- Xcode version 12.2 or later
- iOS 14
- [TMDb](https://developers.themoviedb.org/3/getting-started/introduction) API key

## Contributing
This project is being developed by Vladyslav Gubanov for its use as education project app, for training and improve new technologies in real app. I not expecting to have community contributions here but I’m open to any suggestions and advices for improving the code or new effective solutions.

## Questions
If you have questions about any aspect of this project, please feel free to [open an issue](https://github.com/glaver/movieBase/issues/new). I'd love to hear from you!

## License
MIT License. See [LICENSE](https://github.com/Glaver/MovieBase/blob/master/LICENSE.txt).
