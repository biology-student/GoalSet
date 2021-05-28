//
//  ContentView.swift
//  GoalSet
//
//  Created by Yoshikazu Tsuka on 2021/05/26.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    @FetchRequest(entity: CheckPoint.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)],animation: .spring()) var results : FetchedResults<CheckPoint>
    @Environment(\.managedObjectContext) var context
    
    var body: some View{
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
            
            VStack(spacing:0){
                LineChart()
                    .padding(.horizontal)
                    .frame(height:400)
                
                HStack{
                    Text("CheckPoint")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    Spacer(minLength: 0)
                }
                .padding()
                .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                .background(Color.white)
                
                if results.isEmpty{
                    Spacer()
                    Text("No CheckPoint")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.primary)
                    Spacer()
                } else {
                    ScrollView(.vertical, showsIndicators: false, content: {
                        LazyVStack(alignment: .leading, spacing: 20){
                            
                            ForEach(results) { task in
                                VStack(alignment: .leading, spacing: 5, content: {
                                    Text(task.content ?? "")
                                        .font(.title)
                                        .fontWeight(.bold)
                                    Text(task.date ?? Date(),style: .date)
                                        .fontWeight(.bold)
                                    Divider()
                                })
                                .foregroundColor(.primary)
                                .contextMenu{
                                    Button(action: {
                                        viewModel.EditItem(item: task)
                                    }, label: {
                                        Text("Edit")
                                    })
                                    Button(action: {
                                        context.delete(task)
                                        try! context.save()
                                    }, label: {
                                        Text("Delete")
                                    })
                                }
                            }
                        }
                        .padding()
                    })
                }
            }
            Button(action: {viewModel.isNewData.toggle()}, label: {
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(Color.green)
                    .clipShape(Circle())
            })
            .padding()
        })
        .background(Color.primary.opacity(0.06).ignoresSafeArea(.all, edges: .all))
        .sheet(isPresented: $viewModel.isNewData, content: {
            Sheet(viewModel: viewModel)
        })
            
    }
}







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
