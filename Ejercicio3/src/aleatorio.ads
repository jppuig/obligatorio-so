--  Juan Pedro Puig - 281088
--  Pedro Azambuja - 270218

package Aleatorio is
   subtype Numero_Rango is Integer range 1 .. 3;

   function Generador return Numero_Rango;
end Aleatorio;
