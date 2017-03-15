A Haskell library for parsing /proc/meminfo.

We don't do anything fancy, just stick it into 
a `Map ByteString (Word64, Maybe ByteString)` where the key is the field
name and the value is the numeric value and the optional units field.
