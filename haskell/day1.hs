import Data.List (sort)

main :: IO ()
main = do
  input <- readFile "inputs/day1.txt"

  let inputNumbers = map (map read . words) (lines input) :: [[Int]]
  let xs = map head inputNumbers
  let ys = map last inputNumbers

  -- part 1
  print $ sum $ zipWith (\x y -> abs (x - y)) (sort xs) (sort ys)

  -- part 2
  print $ foldl (\acc x -> acc + (x * (length . filter (== x) $ ys))) 0 xs

  return ()
