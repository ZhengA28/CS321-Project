import math

class Task1Calculator:
    def __init__(self):
        pass

    def nth_root(self, n, a):
        """Calculates the nth root of a."""
        return a ** (1 / n)

    def evaluate(self, expression):
        try:
            # Replace custom symbols with Python operators
            expression = expression.replace('✕', '*')
            expression = expression.replace('➗', '/')
            expression = expression.replace('^', '**')

            # Handle nth root notation, e.g., 3√27 -> nth_root(3, 27)
            while '√' in expression:
                idx = expression.index('√')
                base_idx = idx - 1
                # Get the base number before the root symbol
                while base_idx >= 0 and (expression[base_idx].isdigit() or expression[base_idx] == '.'):
                    base_idx -= 1
                base_idx += 1
                base = float(expression[base_idx:idx])

                # Find the end of the number after the root symbol
                end_idx = idx + 1
                while end_idx < len(expression) and (expression[end_idx].isdigit() or expression[end_idx] == '.'):
                    end_idx += 1
                radicand = float(expression[idx + 1:end_idx])

                # Replace the nth root notation with a function call to nth_root
                result = self.nth_root(base, radicand)
                expression = expression[:base_idx] + str(result) + expression[end_idx:]

            # Evaluate the expression with error handling
            result = eval(expression, {"__builtins__": None}, {
                "sin": math.sin,
                "cos": math.cos,
                "tan": math.tan,
                "pow": math.pow,
                "sqrt": math.sqrt
            })

            if result == float('inf') or result == float('-inf') or math.isnan(result):
                return "undefined"
            else:
                return result
        except ZeroDivisionError:
            return "undefined"
        except OverflowError:
            return "undefined"
        except Exception as e:
            return f"Error: {e}"

# Test cases
calc = Task1Calculator()

# Valid expression with brackets and custom operators
print(calc.evaluate("((3.5 + 4.9) - (10 ➗ 2)) ✕ 3.40"))  # Output: 11.56

# Division by zero
print(calc.evaluate("4 ➗ 0"))  # Output: undefined

# nth root (cube root of 27)
print(calc.evaluate("3√27"))  # Output: 3.0

# Large number
print(calc.evaluate("99999^9"))  # Output: 99999

# Overflow case
print(calc.evaluate("14567853455434591234 + 234321427837402492"))  # Large number output
