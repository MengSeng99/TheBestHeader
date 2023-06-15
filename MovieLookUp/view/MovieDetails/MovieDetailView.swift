//
//  MovieDetailView.swift
//  MovieLookUp
//
//  Created by student on 14/06/2023.
//

import Foundation
import SwiftUI

struct MovieDetailView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var model = MovieDetailsViewModel()
    let movie: Movie
    let headerHeight: CGFloat = 300
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 39/255, green: 40/255, blue: 59/255)
                    .ignoresSafeArea()
                
                GeometryReader { geo in
                    VStack {
                        AsyncImage(url: movie.backdropURL) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: geo.size.width, maxHeight: headerHeight)
                        } placeholder: {
                            ProgressView()
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                }
                
                ScrollView {
                    VStack(spacing: 15) {
                        Spacer()
                            .frame(height: headerHeight)
                        
                        HStack {
                            Text(movie.title)
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            Spacer()
                        }
                        
                        HStack {
                            Text("About film")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal)

                            Spacer()
                        }
                        
                        Text(movie.overview)
                            .lineLimit(2)
                            .foregroundColor(.gray)
                            .padding(.horizontal)

                        
                        HStack {
                            Text("Cast & Crew")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            Spacer()

                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(model.castProfiles) { cast in
                                    CastView(cast: cast)
                                }
                            }
                        }
                    }
                }
            }
            .foregroundColor(.white)
            .navigationBarHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .imageScale(.large)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            Task {
                await model.movieCredits(for: movie.id)
                await model.loadCastProfiles()
            }
        }
    }
    struct MovieDetailView_Previews: PreviewProvider {
        static var previews: some View {
            MovieDetailView(movie: .preview)
        }
    }
}

