module System.Mem where

import System.Mem.Internal
import Data.Attoparsec (parseOnly)
import Data.ByteString (ByteString)
import qualified Data.ByteString as B

parseMemInfo :: ByteString -> Maybe MemInfo
parseMemInfo bs = case parseOnly parseFile bs of
    Left _ -> Nothing
    Right x -> Just x

-- | Read `/proc/meminfo` and parse it into a `MemInfo`
getMemInfo :: IO MemInfo
getMemInfo = parseMemInfo <$> B.readFile "/proc/meminfo"
