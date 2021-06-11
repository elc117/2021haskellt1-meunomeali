-- testando

import Text.Printf

type Point     = (Float,Float)
type Rect      = (Point,Float,Float)


svgRect :: Rect -> String -> String 
svgRect ((x,y),w,h) style = 
  printf "<rect x='%.3f' y='%.3f' width='%.2f' height='%.2f' style='%s' />\n" x y w h style

-- String inicial do SVG
svgBegin :: Float -> Float -> String
svgBegin w h = printf "<svg width='%.2f' height='%.2f' xmlns='http://www.w3.org/2000/svg'>\n" w h 

-- String final do SVG
svgEnd :: String
svgEnd = "</svg>"

-- apenas testando, mudar de cor no futuro
genReds :: Int -> [(Int,Int,Int)]
genReds numRepet =  map (\red -> ( (if red >= 255 then 255 else red),0,0) ) $ take (numRepet*numRepet) (iterate (newRed+) firstRed)
  where newRed = 1
        firstRed = 1


-- coordenadas de cada retângulo
genRectsInLine1 :: Int -> Int -> [Rect]
genRectsInLine1 n aleat = [( (fromIntegral (m*((quot (aleat * n) (m+1)) + w)),fromIntegral (x*(w+gap) `quot` 2 )),fromIntegral w,h ) | m <- [0..fromIntegral (n-1)], x <- [0..fromIntegral (n-1)]]
  where (w,h) = (50,50)
        gap = 2


-- Gera string com atributos de estilo para uma dada cor
-- Atributo mix-blend-mode permite misturar cores
svgStyle :: (Int,Int,Int) -> String
svgStyle (r,g,b) = printf "fill:rgb(%d,%d,%d)" r g b

-- Gera strings SVG para uma dada lista de figuras e seus atributos de estilo
-- Recebe uma função geradora de strings SVG, uma lista de círculos/retângulos e strings de estilo
svgElements :: (a -> String -> String) -> [a] -> [String] -> String
svgElements func elements styles = concat $ zipWith func elements styles



main :: IO ()
main = do
  writeFile "teste.svg" $ svgstrs
  where svgstrs = svgBegin w h ++ svgfigs1 ++ svgEnd
        -- tons de vermelho
        svgfigs1 = svgElements svgRect rects1 (map svgStyle palette1)
        rects1 = genRectsInLine1 nrects aleatorizador
        palette1 = genReds nrects
        
        aleatorizador = 7
        nrects = 15

        (w,h) = (1500,1500) -- width,height da imagem SVG