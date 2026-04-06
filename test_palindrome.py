import pytest
from palindrome import is_palindrome


class TestIsPalindrome:
    """Tests for the is_palindrome function."""

    def test_simple_palindrome(self):
        assert is_palindrome("racecar") is True

    def test_single_character(self):
        assert is_palindrome("a") is True

    def test_empty_string(self):
        assert is_palindrome("") is True

    def test_not_a_palindrome(self):
        assert is_palindrome("hello") is False

    def test_case_insensitive(self):
        assert is_palindrome("RaceCar") is True

    def test_with_spaces(self):
        assert is_palindrome("A man a plan a canal Panama") is True

    def test_with_punctuation(self):
        assert is_palindrome("Was it a car or a cat I saw?") is True

    def test_numeric_palindrome(self):
        assert is_palindrome("12321") is True

    def test_numeric_not_palindrome(self):
        assert is_palindrome("12345") is False

    def test_mixed_alphanumeric(self):
        assert is_palindrome("A1b2b1a") is True

    def test_two_characters_palindrome(self):
        assert is_palindrome("aa") is True

    def test_two_characters_not_palindrome(self):
        assert is_palindrome("ab") is False

    def test_only_special_characters(self):
        assert is_palindrome("!@#$%") is True  # cleaned string is empty
