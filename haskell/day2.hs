toPairs :: [a] -> [(a, a)]
toPairs [] = []
toPairs [x] = []
toPairs (x : xs) = (x, head xs) : toPairs xs

increasing (x, y) = 1 <= (y - x) && (y - x) <= 3

decreasing (x, y) = 1 <= (x - y) && (x - y) <= 3

createPermutations :: [Int] -> [[Int]]
createPermutations [] = []
createPermutations (x : xs) = (x : xs) : xs : map (x :) (createPermutations xs)

isSafe :: [(Int, Int)] -> Bool
isSafe xs = all increasing xs || all decreasing xs

main :: IO ()
main = do
  input <- readFile "inputs/day2.txt"
  let reports = map (map read . words) (lines input) :: [[Int]]

  -- part 1
  print $ length . filter isSafe $ map toPairs reports

  -- part 2
  print $ length . filter (any isSafe) $ map (map toPairs . createPermutations) reports

  return ()
