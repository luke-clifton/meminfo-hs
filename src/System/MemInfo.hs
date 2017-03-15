module System.MemInfo where

import System.MemInfo.Internal
import Data.Attoparsec.ByteString.Char8 (parseOnly)
import Data.ByteString (ByteString)
import qualified Data.ByteString as B

parseMemInfo :: ByteString -> Maybe MemInfo
parseMemInfo bs = case parseOnly parseFile bs of
    Left _ -> Nothing
    Right x -> Just x

-- | Read `/proc/meminfo` and parse it into a `MemInfo`
getMemInfo :: IO MemInfo
getMemInfo = do
    res <- parseMemInfo <$> B.readFile "/proc/meminfo"
    case res of
        Just x -> return x
        Nothing -> fail "Could not parse /proc/meminfo"
