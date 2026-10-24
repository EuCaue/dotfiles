import unittest
from slug import slugify


class T(unittest.TestCase):
    def test_accents(self): self.assertEqual(slugify("Ação Rápida"), "acao-rapida")
    def test_collapse(self): self.assertEqual(slugify("a  --  b"), "a-b")
    def test_trim(self): self.assertEqual(slugify("  -x- "), "x")


if __name__ == "__main__":
    unittest.main()
