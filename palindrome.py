def is_palindrome(s: str) -> bool:
    """Check if a string is a palindrome.

    The check is case-insensitive and ignores non-alphanumeric characters.

    Args:
        s: The string to check.

    Returns:
        True if the string is a palindrome, False otherwise.
    """
    cleaned = "".join(ch.lower() for ch in s if ch.isalnum())
    return cleaned == cleaned[::-1]
