---
allowed-tools: Bash, Read, Write
description: Generate comprehensive tests for a file or function
argument-hint: <file-path> [function-name]
---

## Context

- Detect test framework from project files
- Match existing test patterns in the codebase

## Task

Generate comprehensive tests for: $ARGUMENTS

### Test Categories

**1. Happy Path**

- Normal expected inputs produce correct outputs
- Standard use cases work correctly

**2. Edge Cases**

- Empty inputs (null, undefined, nil, "", [], {})
- Boundary values (0, -1, MAX_INT, empty string)
- Single element collections
- Maximum size inputs

**3. Error Cases**

- Invalid input types
- Missing required parameters
- Network/IO failures (if applicable)
- Permission denied scenarios

**4. Integration Points**

- Interactions with dependencies
- State changes and side effects
- Async behavior (if applicable)

### Test Types by Layer

**Unit Tests**

- Isolated function/method behavior
- Mock external dependencies
- Fast, deterministic

**Controller/Request Specs** (for web apps)

- HTTP response codes
- Rendered templates
- Redirects and flash messages
- Parameter handling

**Model/Domain Specs**

- Validations
- Associations/relationships
- Business logic methods
- Polymorphism and inheritance

**View Specs** (if applicable)

- Template rendering
- Conditional display logic
- Partial rendering

**Integration/Feature Tests**

- Full request cycle
- Multi-step workflows
- Database state changes

### Language-Specific Patterns

**JavaScript/TypeScript (Jest/Vitest/Mocha)**

```javascript
describe("functionName", () => {
  describe("happy path", () => {
    it("should handle normal case", () => {});
  });
  describe("edge cases", () => {
    it("should handle empty input", () => {});
  });
  describe("error handling", () => {
    it("should throw on invalid input", () => {});
  });
});
```

**Ruby (RSpec)**

```ruby
RSpec.describe ClassName do
  describe '#method_name' do
    context 'with valid input' do
      it 'returns expected result' do
      end
    end
    context 'with invalid input' do
      it 'raises appropriate error' do
      end
    end
  end

  # Shared examples for reusable behavior
  it_behaves_like 'a common behavior'
end
```

**Python (pytest)**

```python
class TestClassName:
    def test_happy_path(self):
        pass
    def test_edge_case(self):
        pass
    @pytest.mark.parametrize("input,expected", [...])
    def test_multiple_cases(self, input, expected):
        pass
```

### Rules

- Match existing test file naming conventions in the project
- Follow the project's mocking/fixture patterns
- Each test should test ONE thing
- Test names should describe the behavior, not the implementation
- Avoid testing implementation details
- Prefer real objects over mocks where practical
- Tests should be deterministic (no flaky tests)
- Use shared examples/fixtures for repeated setup
