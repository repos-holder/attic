data Month = Feb | Mar
data Date = Date Int Month

-- my birthday is february
month Feb = True

-- it's not 20th february
notday (Date d Feb) | d /= 20 = True

-- i'm pisces
day (Date d Feb) | d `elem` [19..29] = True
day (Date d Mar) | d `elem` [1..20] = True

-- combine facts
goal (Date d m) =
  d =:= anyOf [1..31] &
  month m &
  notday (Date d m) &
  day (Date d m)

main | goal (Date d m) = (Date d m) where d,m free
