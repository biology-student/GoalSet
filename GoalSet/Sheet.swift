//
//  Sheet.swift
//  GoalSet
//
//  Created by Yoshikazu Tsuka on 2021/05/27.
//

import SwiftUI

struct Sheet: View {
    @ObservedObject var viewModel : ViewModel
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack{
            HStack{
                Text("\(viewModel.updateItem == nil ? "Add New" : "Update") CheckPoint")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.primary)
            }
            .padding()
            TextEditor(text: $viewModel.content)
                .padding()
            Divider()
                .padding(.horizontal)
            HStack{
                Text("Dead Line")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }
            .padding()
                DatePicker("", selection:$viewModel.date, displayedComponents:.date)//日付も使用する場合は”displayedComponents:.date”をなくす
                    .labelsHidden()
        
            Button(action: {viewModel.writeData(context: context)}, label: {
                Label(title:{Text(viewModel.updateItem == nil ? "Add" : "Update")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                },
                icon: {Image(systemName: "plus")
                    .font(.title)
                    .foregroundColor(.white)
                })
                .padding(.vertical)
                .frame(width:UIScreen.main.bounds.width - 30)
                .background(Color.orange)
                .cornerRadius(50)
            })
            .padding()
        }
        .background(Color.primary.opacity(0.06).ignoresSafeArea(.all, edges: .bottom))
    }
}
