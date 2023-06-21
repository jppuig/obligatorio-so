procedure Main is
-- Sala de espera
   task sala is
      entry entrarSala;
      entry salirSala;
   end sala;
   task body sala is
      en_sala:Integer := 0;
   begin
      loop
         select when en_sala < 7 => accept entrarSala;
               en_sala := en_sala + 1;
         or
            accept salirSala;
            en_sala := en_sala -1;
         end select;
      end loop;
   end sala;

-- Equipos
   task equipo1 is
   end equipo1;
   task body equipo1 is
      ya_entro: Boolean_Array := (1..3 => False);
   begin
      loop
         sala.entrarSala;
         Put_Line ("Equipo 1 entra a la sala de espera");

         if ya_entro(1) = False then
            sala.salirSala;
            Put_Line ("Equipo 1 ingresa a la mesa 1");
            delay 3.0;
            Put_Line ("Equipo 1 se va de la mesa 1");
            ya_entro(1) := True;
            mesa.retirarse;
         end if;
         sala.pedirSala;
      end loop;

   end equipo1;

   -- Cada mesa como mutua exclusion para pedir y salir
   task mesa is
      entry pedir;
      entry retirarse;
   end mesa;
   task body mesa is
      en_mesa: Integer := 0;
   begin
      loop
         select when en_mesa < 1 => accept pedir;
               en_mesa := en_mesa + 1;
         or
            accept retirarse;
            en_mesa := en_mesa -1;
         end select;
      end loop;
   end mesa;
   task mesa2 is
      entry pedir2;
      entry retirarse2;
   end mesa2;
   task mesa3 is
      entry pedir3;
      entry retirarse3;
   end mesa3;

begin
   null;
end Main;
