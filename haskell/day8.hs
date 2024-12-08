import Data.Maybe (catMaybes)
import Data.Set (Set, fromList, toList)

data Node = Node Char Int Int
  deriving (Show, Eq, Ord)

eqFreq :: Node -> Node -> Bool
eqFreq (Node c1 _ _) (Node c2 _ _) = c1 == c2

dedupe :: (Ord a) => [a] -> [a]
dedupe = toList . fromList

distance :: Node -> Node -> (Int, Int)
distance (Node _ x1 y1) (Node _ x2 y2) = (x2 - x1, y2 - y1)

offset :: Int -> Node -> Node -> (Int, Int)
offset n n1@(Node _ x1 y1) n2 = (2 * dx + x1, 2 * dy + y1)
  where
    (dx, dy) = distance n1 n2

main :: IO ()
main = do
  input <- lines <$> readFile "inputs/day8.txt"

  let height = length input
  let width = length (head input)

  let valid (x, y) = 0 <= x && x < width && 0 <= y && y < height

  let nodes = [Node c x y | (y, row) <- zip [0 ..] input, (x, c) <- zip [0 ..] row, c /= '.']

  -- part 1
  print $ length $ dedupe [o | n1 <- nodes, n2 <- nodes, let o = offset 2 n1 n2, n1 /= n2, eqFreq n1 n2, valid o]
