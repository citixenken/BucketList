//
//  ContentView.swift
//  BucketList
//
//  Created by Ken Muyesu on 19/02/2022.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct ContentView: View {
    
    //    func getDocumentsDirectory() -> URL {
    //        //find all possible documents directories for this user
    //        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    //
    //        //just send back the first one, ought to be the only one
    //        return paths[0]
    //    }
    @StateObject private var viewModel = ViewModel()
    @State private var isUnlocked = false
    
    
    //    struct Location: Identifiable {
    //        let id = UUID()
    //        let name: String
    //        let coordinate: CLLocationCoordinate2D
    //    }
    //
    //    let locations = [
    //        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
    //        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    //    ]
    
    //    func authenticate() {
    //        let context = LAContext()
    //        var error: NSError?
    //
    //        //check whether biometric authentication is possible
    //        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
    //
    //            //if possible, go ahead and use it
    //            let reason = "We need to unlock your data."
    //
    //            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
    //                //authentication has now completed
    //                if success {
    //                    isUnlocked = true
    //                } else {
    //                    //there was a problem
    //                }
    //
    //            }
    //        } else {
    //            //no biometrics
    //        }
    //    }
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                //MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                MapAnnotation(coordinate: location.coordinate) {
                    VStack {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 20, height: 20)
                            .background(.white)
                            .clipShape(Circle())
                        
                        Text(location.name)
                            .fixedSize()
                    }
                    .onTapGesture {
                        viewModel.selectedPlace = location
                    }
                }
            }
            .ignoresSafeArea()
            
            Circle()
                .fill(.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            VStack {
                
                Spacer()
                
                HStack {
                    Spacer()
                    Button {
                        //create a new location
                        viewModel.addLocation()
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                    
                }
            }
        }
        .sheet(item: $viewModel.selectedPlace) { place in
            //Text(place.name)
            EditView(location: place) { 
                viewModel.update(location: $0)
            }
        }
        
        //        VStack {
        //            if isUnlocked {
        //                Text("Unlocked")
        //            } else {
        //                Text("Locked")
        //            }
        //        }
        //        .onAppear(perform: authenticate)
        
        
        //        NavigationView {
        //            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
        //                MapAnnotation(coordinate: location.coordinate) {
        //                    NavigationLink {
        //                        Text(location.name)
        //                    } label: {
        //                        Circle()
        //                            .stroke(.red, lineWidth: 2)
        //                            .frame(width: 20, height: 20)
        //                        //                        .onTapGesture {
        //                        //                            print("Tapped on \(location.name)")
        //                        //                        }
        //                    }
        //
        //                }
        //
        //            }
        //            .navigationTitle("London Explorer")
        //        }
        
        
        //        Text("Hello, world!")
        //            .onTapGesture {
        //                let str = "Test Message"
        //                let url = getDocumentsDirectory().appendingPathComponent("message.txt")
        //
        //                do {
        //                    try str.write(to: url, atomically: true, encoding: .utf8)
        //                    let input = try String(contentsOf: url)
        //                    print(input)
        //                } catch {
        //                    print(error.localizedDescription)
        //                }
        //            }
        //            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
