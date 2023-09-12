import Data.Time.Clock
import Data.Time.Calendar

date :: IO (Integer, Int, Int) -- :: (year, month, day)
date = getCurrentTime >>= return . toGregorian . utctDay

birthday (_, 2, 29) = "Да ты прикалываешься?"
birthday (_, 2, 20) = "Сожалею, но сегодня мне нечем тебя порадовать"
birthday (_, 2, day) | day `elem` [19..28] = "С днем рожденья, Нина!"
birthday _ = "Сожалею, но сегодня мне нечем тебя порадовать"

main = date >>= return . birthday >>= putStrLn
