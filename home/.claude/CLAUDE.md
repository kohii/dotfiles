## Guidelines for Action
- Always respond in the same language the user is using.
- Feel free to use `gemini-websearch` for web search

## Code Quality
- Consider the overhead of extraction.
  - Extracting functions adds overhead—boilerplate, management burden, and navigation cost. When a function barely abstracts complexity, inline code is clearer.
- Don't extract magic numbers to constants if they are not used in multiple places.
 
## Testing
- **Extract pure functions**: Before writing tests, extract complex business logic into pure functions that are easier to test
  - Dependencies like I/O and specific APIs should be passed as arguments to the function
- **Focus on meaningful logic**: Don't test trivial functions that just call other utilities - focus on functions with actual business rules
- Add/update tests when you implement pure functions
- If a unit test fails, think about the ideal behavior and align with it, instead of modifying the implementation and tests just to make the results add up

## Tips
The Bash tool runs in a sandbox, so file access and network connections may result in errors. In such situations, please consult the user for instructions.
