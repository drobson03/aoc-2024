import Data.List (elemIndex, sort)

data Rule = Rule Int Int
  deriving (Show)

parseOrder :: String -> Rule
parseOrder order = Rule (head nums) (head $ tail nums)
  where
    nums = map read $ words $ map (\x -> if x == '|' then ' ' else x) order :: [Int]

parseUpdate :: String -> [Int]
parseUpdate update = map read $ words $ map (\x -> if x == ',' then ' ' else x) update

correctlyOrdered :: [Rule] -> [Int] -> Bool
correctlyOrdered [] _ = True
correctlyOrdered (Rule x y : rules) update = (x `notElem` update || y `notElem` update || elemIndex x update < elemIndex y update) && correctlyOrdered rules update

middle :: [a] -> a
middle [] = error "middle: empty list"
middle xs = xs !! (length xs `div` 2)

main :: IO ()
main = do
  input <- readFile "inputs/day5.txt"
  let inputLines = lines input
  let pageOrderingRules = map parseOrder $ takeWhile (/= "") inputLines
  let updates = map parseUpdate $ drop 1 $ dropWhile (/= "") inputLines

  let valid = correctlyOrdered pageOrderingRules

  -- part 1
  print $ sum $ map middle $ filter valid updates
