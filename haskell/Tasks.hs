import Data.List (words)
string2int::String -> Int
string2int = read

myMap :: (a->b)->[a]->[b]
myMap _ [] = []
myMap f (x:xs)= f x : myMap f xs 

myFilter :: (a-> Bool)->[a]->[a]
myFilter f xs = [x | x <- xs, f x] 

word2string num= 
  let 
    list= [","," thousand,"," million,"," billion,"," trillion,"]
    word = filter (\x -> if (x `elem` list) then False else True ) (zipWith (++) (transform $ split num) list)
  in init (foldl (\acc x -> x++acc) [] word)
string2word :: String -> Int
string2word str= 
  let
    str1= filter (\x ->  x/=',') str
    wrds = words str1
    words1 = filter (\x -> x/= "and") wrds
    list=  ["thousand","million","billion","trillion"]
    word_grps = foldl (\acc x -> if not (elem x list ) then ((head acc)++" " ++ x):tail acc else "":acc) [""] words1 
    num_grps= reverse $ map converter word_grps
    num_grps2= map (foldl (\acc x-> acc+x) 0) num_grps
    weights = (filter (\x->x `elem` list) words1) ++ ["one"]
    lookup word= case word of
      "trillion"->10^12
      "billion"->10^9
      "million"->10^6
      "thousand"->10^3 
      "one"->1
      word -> error word
    addWeight num weight= num * (lookup weight)
    number_list= zipWith addWeight num_grps2 weights
    in foldl (\acc x -> acc+x) 0 number_list
converter str=
  let 
    wrds= words str
    lookfor word= case word of 
      "one"->1
      "two"->2
      "three"->3
      "four"->4
      "five"->5
      "six"->6
      "seven"->7
      "eight"->8
      "nine"->9
      "ten"->10
      "eleven"->11
      "twelve"->12
      "thirteen"->13
      "fourteen"->14
      "fifteen"->15
      "sixteen"->16
      "seventeen"->17
      "eighteen"->18
      "nineteen"->19
      "twenty"->20
      "thirty"->30
      "forty"->40
      "fifty"->50
      "sixty"->60
      "seventy"->70
      "eighty"->80
      "ninety"->90
      word -> error word
    change []= [] 
    change (x:xs) = lookfor x : change xs
    number = change (filter (\x -> x/= "hundred") wrds)
  in if "hundred" `elem` wrds then (head number *100):(tail number) else number

split :: (Integral a)=> a-> [a]
split num 
  | num < 1000 = num:[]
  | otherwise = (num `mod` 1000 ): split (num `div` 1000)

transform :: [Int] -> [[Char]]
transform [] =[]
transform (num:xs) =
  let 
    ones x = case x of
      1 -> " one"
      2 -> " two"
      3 -> " three"
      4 -> " four"
      5 -> " five"
      6 -> " six"
      7 -> " seven"
      8 -> " eight"
      9 -> " nine"
      0 -> ""
    tens' x= case x of 
      10 -> " ten"
      11 -> " eleven"
      12 -> " twelve"
      13 -> " thirteen"
      14 -> " fourteen"
      15 -> " fifteen"
      16 -> " sixteen"
      17 -> " seventeen"
      18 -> " eighteen"
      19 -> " nineteen"
    tens x= case x of 
      2 -> " twenty"
      3 -> " thirty"
      4 -> " forty"
      5 -> " fifty"
      6 -> " sixty"
      7 -> " seventy"
      8 -> " eighty"
      9 -> " ninety"
      0 -> ""
    hundreds x =case x of
      0-> ""
      x-> ones x ++ " hundred"
    number= 
      let 
        fst_dig= num `div` 100
        scnd_dig= mod ( num `div` 10) 10
        trd_dig = mod num 10
        and 
          |fst_dig /= 0 && (scnd_dig /=0 || trd_dig /=0) =" and"
          | otherwise = ""
      in (hundreds fst_dig) ++ and ++ case scnd_dig of
        1 -> " " ++ (tens' (num `mod` 100))
        scnd_dig ->(tens scnd_dig) ++ (ones trd_dig )
  in number:transform xs
