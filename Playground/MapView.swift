//
//  MapView.swift
//  Playground
//
//  Created by Aluno 17 on 17/04/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    // Coordenadas iniciais (Apple Park como exemplo)
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.334_900, longitude: -122.009_020),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    // Locais para marcar no mapa
    let locations = [
        Location(name: "Apple Park", coordinate: CLLocationCoordinate2D(latitude: 37.334_900, longitude: -122.009_020))
    ]
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: locations) { location in
            MapMarker(coordinate: location.coordinate, tint: .red)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
