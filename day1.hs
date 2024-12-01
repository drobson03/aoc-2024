import Data.List (sort)

getTotalDistance :: [Int] -> [Int] -> Int
getTotalDistance [] [] = 0
getTotalDistance [] _ = 0
getTotalDistance _ [] = 0
getTotalDistance (x : xs) (y : ys) = abs (x - y) + getTotalDistance xs ys

getScore :: [Int] -> Int -> Int
getScore [] _ = 0
getScore ys x = (length . filter (== x) $ ys) * x

main :: IO ()
main = do
  input <- readFile "day1_input.txt"

  let inputNumbers = map (map read . words) (lines input) :: [[Int]]
  let xs = map head inputNumbers
  let ys = map last inputNumbers

  -- part 1
  print $ getTotalDistance (sort xs) (sort ys)

  -- part 2
  print $ sum $ map (getScore ys) xs

  return ()
