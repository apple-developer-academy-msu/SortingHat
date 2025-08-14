import SwiftUI

enum Cohort: String, CaseIterable {
    case AM
    case PM
}

enum SortingMethod: Int, CaseIterable {
    case three = 3
    case four = 4
    case five = 5
}



struct SortingView: View {
    @State private var currentSelection: SortingMethod = .five
    @State private var currentCohort: Cohort = .AM
    var teamSortManager = StudentRandomizer()
    let minColumnWidth: CGFloat = 200
    
    var body: some View {
        ZStack {
       
            LinearGradient(
                colors: [
                    Color.green.opacity(0.2),
                    Color.white,
                    Color.blue.opacity(0.15)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                VStack{
                    Picker("Cohort", selection: $currentCohort) {
                        ForEach(Cohort.allCases, id: \.self) { method in
                            Text(method.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.top, 20)
                    
                    
                    Picker("Members per team", selection: $currentSelection) {
                        ForEach(SortingMethod.allCases, id: \.self) { method in
                            Text("\(method.rawValue)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .frame(width: 400)
            
                HStack(spacing: 16) {
                    
                    Button(action: {
                        Task {
                            await teamSortManager.loadLearners()
                             teamSortManager.sortLearners(intoTeamsOf: currentSelection.rawValue)
                        }
                        Task {
                            await teamSortManager.loadLearners()
                            
                        
                        }
                    }) {
                        Label("Sort", systemImage: "arrow.2.squarepath")
                    }
                    .buttonStyle(.borderedProminent)
                    
                   
                    Button(action: {
#if os(macOS)
                        copyTeamsToClipboard()
#endif
                    }) {
                        Label("Copy", systemImage: "doc.on.doc")
                    }
                    .buttonStyle(.bordered)
             
                }
                .padding(.bottom, 10)
             
                
               
                GeometryReader { geo in
                    let availableWidth = geo.size.width - 200
                    let columns = max(Int(availableWidth / minColumnWidth), 1)
                    let layout = Array(repeating: GridItem(.flexible(), spacing: 20), count: columns)
                    
                    ScrollView {
                        LazyVGrid(columns: layout, spacing: 20) {
                            ForEach(teamSortManager.sortedTeams ) { team in
                                VStack(spacing: 12) {
                                    Text("Team")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    
                                    Divider()
                                        .background(Color.white.opacity(0.4))
                                    
                                    ForEach(team.learners) { learner in
                                        Text("\(learner.first) \(learner.last)")
                                        
                                    }
                                   
                                }
                                .frame(minWidth: 200, maxWidth: 200, minHeight: 200, maxHeight: 400)
                                .padding()
                                .background(
                                    LinearGradient(
                                        colors: [.green.opacity(0.8), .blue.opacity(0.6)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                    .cornerRadius(20)
                                )
                                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                                .shadow(color: .green.opacity(0.3), radius: 20, x: 0, y: 10)
                                .scaleEffect(1.0)
                               // .animation(.spring(response: 0.3), value: team.id)
                            }
                        }
                        .padding(.horizontal, 100)
                    }
                }
            }
            .padding()
        }
        .preferredColorScheme(.light)
    }
    
    #if os(macOS)
    func copyTeamsToClipboard() {
        let allTeamsText = teamSortManager.sortedTeams
            .enumerated()
            .map { index, team in
                """
                Team \(index + 1):
                \(team.learners.map { "\($0.first) \($0.last)" }.joined(separator: "\n"))
                """
            }
            .joined(separator: "\n\n")
        
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(allTeamsText, forType: .string)
    }
    #endif
}

#Preview {
    SortingView()
}


