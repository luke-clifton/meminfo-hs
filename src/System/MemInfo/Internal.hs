module System.MemInfo.Internal where

import qualified Data.ByteString.Char8 as B
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Word
import Data.Attoparsec.ByteString.Char8 as A
import Control.Applicative

type MemInfo = Map B.ByteString (Word64, Maybe B.ByteString)

parseKey :: Parser B.ByteString
parseKey = A.takeWhile1 (/=':')

parseValue :: Parser Word64
parseValue = decimal

parseUnits :: Parser B.ByteString
parseUnits = A.takeWhile1 isAlpha_ascii

parseLine :: Parser (B.ByteString, (Word64, Maybe B.ByteString))
parseLine = do
    key <- parseKey
    _ <- char ':'
    skipSpace
    value <- parseValue
    mUnits <- optional (skipWhile (==' ') *> parseUnits)
    endOfLine
    return (key, (value, mUnits))

parseFile :: Parser MemInfo
parseFile = (Map.fromList <$> many parseLine) <* endOfInput
