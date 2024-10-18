import unittest
import math
from Task1 import Task1Calculator

class TestTask1Calculator(unittest.TestCase):
    def setUp(self):
        self.calc = Task1Calculator()

    def test_basic_operations(self):
        self.assertAlmostEqual(self.calc.evaluate("2 + 3"), 5)
        self.assertAlmostEqual(self.calc.evaluate("5 - 3"), 2)
        self.assertAlmostEqual(self.calc.evaluate("4 ✕ 3"), 12)
        self.assertAlmostEqual(self.calc.evaluate("10 ➗ 2"), 5)

    def test_trigonometric_functions(self):
        self.assertAlmostEqual(self.calc.evaluate("sin(0)"), 0)
        self.assertAlmostEqual(self.calc.evaluate("cos(0)"), 1)
        self.assertAlmostEqual(self.calc.evaluate("tan(0)"), 0)

    def test_power_and_roots(self):
        self.assertAlmostEqual(self.calc.evaluate("2^3"), 8)
        self.assertAlmostEqual(self.calc.evaluate("2√9"), 3)
        self.assertAlmostEqual(self.calc.evaluate("3√27"), 3)

    def test_brackets(self):
        self.assertAlmostEqual(self.calc.evaluate("(2 + 3) ✕ 4"), 20)
        self.assertAlmostEqual(self.calc.evaluate("((3 + 4) - (10 ➗ 2)) ✕ 3"), 9)

    def test_order_of_precedence(self):
        self.assertAlmostEqual(self.calc.evaluate("2 + 3 ✕ 4"), 14)
        self.assertAlmostEqual(self.calc.evaluate("6 ➗ 2 ✕ 9"), 27)

    def test_undefined_results(self):
        self.assertEqual(self.calc.evaluate("4 ➗ 0"), "undefined")
        self.assertEqual(self.calc.evaluate("tan(90)"), "undefined")

    def test_large_numbers(self):
        result = self.calc.evaluate("14567853455434591234 + 234321427837402492")
        self.assertEqual(result, 14802174883271993726)

    def test_complex_expressions(self):
        expr = "sin(45) + cos(30) ✕ (2√16 - 3√27) ^ 2"
        self.assertAlmostEqual(self.calc.evaluate(expr), 0.7071067811865476)

    def test_error_handling(self):
        self.assertIn("Error", self.calc.evaluate("2 + ✕ 3"))

if __name__ == '__main__':
    unittest.main()
