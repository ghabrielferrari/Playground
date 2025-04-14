//
//  ContentView.swift
//  Playground
//
//  Created by Aluno 17 on 10/04/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack
        {
            VStack(alignment: .leading){
                Text("Login")
                    .font(.system(size: 24, weight: .semibold))
                    .padding()
                    .multilineTextAlignment(.leading)
                    .font(.largeTitle)
                Spacer()
            }
        }
        .frame(width: 350, height: 750, alignment: .leading)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
