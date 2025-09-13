# Code Overview Generator

## Arguments
$ARGUMENTS

## Instructions
Analyze "Arguments" comprehensively - both the target itself AND its surrounding context:

1. **Discover Context**:
   - Find target: "$ARGUMENTS"
   - Map ALL related files, parent modules, sibling components
   - Trace upstream dependencies and downstream consumers
   - Identify architectural layer and domain boundaries

2. **Analyze Structure**:
   - **Target itself**: Internal structure, methods, properties
   - **Inbound**: What depends on this? Who calls it? What data comes in?
   - **Outbound**: What does it depend on? What does it call? What data goes out?
   - **Siblings**: Related components at same abstraction level
   - **Hierarchy**: Parent modules/packages and position in overall architecture

3. **Extract Relationships**:
```
Layer Position: [Presentation|Application|Domain|Infrastructure]
Module Tree: parent > current > children
Dependencies: upstream → TARGET → downstream
``````

4. **Core Understanding**:
   - **Purpose & Responsibility**: Why does this exist?
   - **Contracts**: Interfaces, APIs, protocols it implements/exposes
   - **Patterns**: Design patterns, architectural styles used
   - **State & Lifecycle**: How it's initialized, managed, destroyed
   - **Critical Paths**: Most important execution flows through this code

5. **Output** to `docs/overview-{timestamp}.md`:
   - **Context Map**: Tree structure showing position in codebase
   - **Dependency Matrix**: Table [Component | Relationship | Type | Purpose]
   - **Interface Contracts**: Structured list of public APIs/methods
   - **Data Flow**: Input types → Transformations → Output types
   - **Collaboration Map**: Who talks to whom and why
   - **Key Insights**: Critical knowledge for understanding this code
   - **Navigation Guide**: Where to look next for deeper understanding

Use Mermaid for complex relationships, structured tables/lists for simpler ones.
Focus on "understanding the context" not just the address.
