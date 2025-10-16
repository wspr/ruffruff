import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Line Length")) {
                    Stepper(value: $appState.ruffConfiguration.lineLength, in: 40...120) {
                        HStack {
                            Text("Max Line Length")
                            Spacer()
                            Text("\(appState.ruffConfiguration.lineLength)")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                Section(header: Text("Rule Selection")) {
                    NavigationLink(destination: RuleSelectionView(rules: $appState.ruffConfiguration.selectRules)) {
                        VStack(alignment: .leading) {
                            Text("Selected Rules")
                            Text(appState.ruffConfiguration.selectRules.joined(separator: ", "))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    NavigationLink(destination: RuleIgnoreView(rules: $appState.ruffConfiguration.ignoreRules)) {
                        VStack(alignment: .leading) {
                            Text("Ignored Rules")
                            if appState.ruffConfiguration.ignoreRules.isEmpty {
                                Text("None")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            } else {
                                Text(appState.ruffConfiguration.ignoreRules.joined(separator: ", "))
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                
                Section(header: Text("About")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                    
                    Link("Ruff Documentation", destination: URL(string: "https://docs.astral.sh/ruff/")!)
                }
                
                Section {
                    Button("Reset to Defaults") {
                        appState.ruffConfiguration = RuffConfiguration()
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

// View for selecting rules to enable
struct RuleSelectionView: View {
    @Binding var rules: [String]
    @State private var newRule = ""
    
    let commonRules = [
        ("E", "Pycodestyle Error"),
        ("F", "Pyflakes"),
        ("W", "Pycodestyle Warning"),
        ("C90", "McCabe Complexity"),
        ("I", "isort"),
        ("N", "pep8-naming"),
        ("D", "pydocstyle"),
        ("UP", "pyupgrade"),
        ("B", "flake8-bugbear"),
        ("A", "flake8-builtins"),
        ("C4", "flake8-comprehensions"),
        ("T20", "flake8-print"),
        ("SIM", "flake8-simplify")
    ]
    
    var body: some View {
        Form {
            Section(header: Text("Selected Rules")) {
                ForEach(rules, id: \.self) { rule in
                    HStack {
                        Text(rule)
                        Spacer()
                        Button(action: {
                            rules.removeAll { $0 == rule }
                        }) {
                            Image(systemName: "minus.circle.fill")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            
            Section(header: Text("Available Rules")) {
                ForEach(commonRules, id: \.0) { rule, description in
                    Button(action: {
                        if !rules.contains(rule) {
                            rules.append(rule)
                        }
                    }) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(rule)
                                    .foregroundColor(.primary)
                                Text(description)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            if rules.contains(rule) {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.accentColor)
                            }
                        }
                    }
                }
            }
            
            Section(header: Text("Custom Rule")) {
                HStack {
                    TextField("Rule Code (e.g., E501)", text: $newRule)
                        .autocapitalization(.allCharacters)
                    
                    Button(action: {
                        if !newRule.isEmpty && !rules.contains(newRule) {
                            rules.append(newRule)
                            newRule = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.accentColor)
                    }
                    .disabled(newRule.isEmpty)
                }
            }
        }
        .navigationTitle("Select Rules")
    }
}

// View for ignoring specific rules
struct RuleIgnoreView: View {
    @Binding var rules: [String]
    @State private var newRule = ""
    
    var body: some View {
        Form {
            Section(header: Text("Ignored Rules")) {
                if rules.isEmpty {
                    Text("No rules ignored")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(rules, id: \.self) { rule in
                        HStack {
                            Text(rule)
                            Spacer()
                            Button(action: {
                                rules.removeAll { $0 == rule }
                            }) {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
            }
            
            Section(header: Text("Add Rule to Ignore")) {
                HStack {
                    TextField("Rule Code (e.g., E501)", text: $newRule)
                        .autocapitalization(.allCharacters)
                    
                    Button(action: {
                        if !newRule.isEmpty && !rules.contains(newRule) {
                            rules.append(newRule)
                            newRule = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.accentColor)
                    }
                    .disabled(newRule.isEmpty)
                }
            }
        }
        .navigationTitle("Ignore Rules")
    }
}
