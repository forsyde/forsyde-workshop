module Main (main) where

import SY_FirstSteps
import ForSyDe.Shallow

main :: IO ()
main = print $ counter' (signal [Up, Up, Up, Reset, Up])
