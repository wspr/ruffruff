"""Sample Python file to test RuffRuff app."""

import os
import sys


def hello_world():
    """Print hello world message."""
    print("Hello, World!")
    x = 1
    y = 2
    # This line is intentionally too long to demonstrate Ruff's line length checking capabilities
    very_long_variable_name = "This is a very long string that exceeds the recommended line length and should trigger a warning"
    return x + y


class MyClass:
    """A sample class."""

    def __init__(self, name):
        """Initialize the class."""
        self.name = name
        unused_variable = "This variable is never used"

    def greet(self):
        """Greet the user."""
        print(f"Hello, {self.name}!")


if __name__ == "__main__":
    hello_world()
    obj = MyClass("Python Developer")
    obj.greet()
