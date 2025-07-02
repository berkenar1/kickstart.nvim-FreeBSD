#!/usr/bin/env python3
"""
Test file to demonstrate the enhanced kickstart.nvim configuration
This file shows various language features that should be highlighted
and supported by our LSP configuration.
"""

import os
import sys
from typing import List, Dict, Optional

class ExampleClass:
    """An example class to demonstrate Python features."""
    
    def __init__(self, name: str, data: Optional[Dict] = None):
        self.name = name
        self.data = data or {}
    
    def process_data(self, items: List[str]) -> Dict[str, int]:
        """Process a list of items and return counts."""
        result = {}
        for item in items:
            result[item] = result.get(item, 0) + 1
        return result
    
    def save_to_file(self, filename: str) -> bool:
        """Save data to a file."""
        try:
            with open(filename, 'w') as f:
                for key, value in self.data.items():
                    f.write(f"{key}: {value}\n")
            return True
        except Exception as e:
            print(f"Error saving file: {e}")
            return False

def main():
    """Main function to run the example."""
    example = ExampleClass("test", {"count": 42, "status": "active"})
    
    # This should trigger formatting with black/isort
    items = [    "apple",    "banana",   "apple",    "cherry"    ]
    
    counts = example.process_data(items)
    print(f"Item counts: {counts}")
    
    # This comment should be easily toggled with comment.nvim
    example.save_to_file("output.txt")

if __name__ == "__main__":
    main()