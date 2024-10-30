import unittest

from contains_duplicate import Solution


class TestContainsDuplicate(unittest.TestCase):
    def setUp(self):
        self.solution = Solution()

    def test_empty_list(self):
        self.assertFalse(self.solution.contains_duplicate([]))

    def test_no_duplicates(self):
        self.assertFalse(self.solution.contains_duplicate([1, 2, 3, 4]))

    def test_with_duplicates(self):
        self.assertTrue(self.solution.contains_duplicate([1, 2, 3, 1]))

    def test_with_multiple_duplicates(self):
        self.assertTrue(self.solution.contains_duplicate([1, 2, 2, 3, 3, 4]))


if __name__ == '__main__':
    unittest.main()
