-- Claude assisted with this

import Data.Char (isDigit)
import Data.Maybe (fromMaybe)
import Text.ParserCombinators.Parsec

data Part = Part1 | Part2

data Instruction = Mul Int Int | Do | Dont
  deriving (Show)

parseNumber :: Parser Int
parseNumber = read <$> many1 digit

parseDo :: Parser Instruction
parseDo = try (string "do()" >> return Do)

parseDont :: Parser Instruction
parseDont = try (string "don't()" >> return Dont)

parseMul :: Parser Instruction
parseMul = try $ do
  string "mul("
  f <- parseNumber
  string ","
  g <- parseNumber
  string ")"
  return $ Mul f g

parseInput :: Parser [Maybe Instruction]
parseInput = many $ (Just <$> (parseDo <|> parseDont <|> parseMul)) <|> (anyChar >> return Nothing)

processInstructions :: Part -> [Maybe Instruction] -> Int
processInstructions Part1 = sum . map multiply
  where
    multiply (Just (Mul f g)) = f * g
    multiply _ = 0
processInstructions Part2 = go True 0
  where
    go _ acc [] = acc
    go doing acc (Nothing : xs) = go doing acc xs
    go True acc (Just (Mul f g) : xs) = go True (acc + f * g) xs
    go False acc (Just Do : xs) = go True acc xs
    go _ acc (Just Dont : xs) = go False acc xs
    go enabled acc (_ : xs) = go enabled acc xs

main :: IO ()
main = do
  input <- readFile "inputs/day3.txt"

  let parseResult = parse parseInput "input" input

  print $ processInstructions Part1 <$> parseResult
  print $ processInstructions Part2 <$> parseResult

  return ()
