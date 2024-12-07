import Control.Monad (replicateM)
import Data.List

data Equation = Equation Int [Int]
  deriving (Show)

getResult :: Equation -> Int
getResult (Equation x _) = x

parseEquation :: String -> Equation
parseEquation equation = Equation (read $ takeWhile (/= ':') equation) (map read $ words $ tail $ dropWhile (/= ':') equation)

concatDigits :: Int -> Int -> Int
concatDigits x y = read $ concatMap show [x, y]

correct :: String -> Equation -> Bool
correct "part1" (Equation x (y : ys)) = elem x $ map (foldl (\acc (a, op) -> op acc a) y . zip ys) (replicateM (length ys) [(+), (*)])
correct "part2" (Equation x (y : ys)) = elem x $ map (foldl (\acc (a, op) -> op acc a) y . zip ys) (replicateM (length ys) [(+), (*), concatDigits])

main :: IO ()
main = do
  input <- readFile "inputs/day7.txt"
  let inputLines = lines input

  print $ sum $ map getResult $ filter (correct "part1") $ map parseEquation inputLines
  print $ sum $ map getResult $ filter (correct "part2") $ map parseEquation inputLines
