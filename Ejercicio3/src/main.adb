with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Aleatorio; use Aleatorio;

procedure Main is
-- Definimos el tipo para poder inicializar en False
   type Boolean_Array is array(1 .. 3) of Boolean;

-- Sala de espera
   task sala is
      entry entrarSala;
      entry salirSala;
   end sala;
   task body sala is
      en_sala:Integer := 0;
   begin
      loop
         select when en_sala < 6 => accept entrarSala;
               en_sala := en_sala + 1;
         or
            accept salirSala;
            en_sala := en_sala -1;
         end select;
      end loop;
   end sala;

-- Mesas
-- Cada mesa como mutua exclusion para pedir y salir
   task mesa1 is
      entry pedir;
      entry retirarse;
   end mesa1;
   task body mesa1 is
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
   end mesa1;

   task mesa2 is
      entry pedir;
      entry retirarse;
   end mesa2;
   task body mesa2 is
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
   end mesa2;

   task mesa3 is
      entry pedir;
      entry retirarse;
   end mesa3;
   task body mesa3 is
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
   end mesa3;

-- Equipos
   task equipo1 is
   end equipo1;
   task body equipo1 is
      ya_entro: Boolean_Array := (1 .. 3 => False);
      prox: Integer;
   begin
      while not (ya_entro(1) and ya_entro(2) and ya_entro(3)) loop
         sala.entrarSala;
         Put_Line ("Equipo 1 entra a la sala de espera");

         prox := Num_Aleatorio(1, 3);
         while ya_entro(prox) = True loop
            prox := Num_Aleatorio(1, 3);
         end loop;

         Put_Line ("Hola");
         if prox = 1 then
            mesa1.pedir;
            sala.salirSala;
            Put_Line ("Equipo 1 ingresa a la mesa 1");
            delay 3.0;
            Put_Line ("Equipo 1 se va de la mesa 1");
            ya_entro(1) := True;
            mesa1.retirarse;
         elsif prox = 2 then
            mesa2.pedir;
            sala.salirSala;
            Put_Line ("Equipo 1 ingresa a la mesa 2");
            delay 3.0;
            Put_Line ("Equipo 1 se va de la mesa 2");
            ya_entro(2) := True;
            mesa2.retirarse;
         elsif prox = 3 then
            mesa3.pedir;
            sala.salirSala;
            Put_Line ("Equipo 1 ingresa a la mesa 3");
            delay 3.0;
            Put_Line ("Equipo 1 se va de la mesa 3");
            ya_entro(3) := True;
            mesa3.retirarse;
         end if;
      end loop;
   end equipo1;

   task equipo2 is
   end equipo2;
   task body equipo2 is
      ya_entro: Boolean_Array := (1 .. 3 => False);
      prox: Integer;
   begin
      while not (ya_entro(1) and ya_entro(2) and ya_entro(3)) loop
         sala.entrarSala;
         Put_Line ("Equipo 2 entra a la sala de espera");

         prox := Num_Aleatorio(1, 3);
         while ya_entro(prox) = True loop
            prox := Num_Aleatorio(1, 3);
         end loop;

         if prox = 1 then
            mesa1.pedir;
            sala.salirSala;
            Put_Line ("Equipo 2 ingresa a la mesa 1");
            delay 3.0;
            Put_Line ("Equipo 2 se va de la mesa 1");
            ya_entro(1) := True;
            mesa1.retirarse;
         elsif prox = 2 then
            mesa2.pedir;
            sala.salirSala;
            Put_Line ("Equipo 2 ingresa a la mesa 2");
            delay 3.0;
            Put_Line ("Equipo 2 se va de la mesa 2");
            ya_entro(2) := True;
            mesa2.retirarse;
         elsif prox = 3 then
            mesa3.pedir;
            sala.salirSala;
            Put_Line ("Equipo 2 ingresa a la mesa 3");
            delay 3.0;
            Put_Line ("Equipo 2 se va de la mesa 3");
            ya_entro(3) := True;
            mesa3.retirarse;
         end if;
      end loop;
   end equipo2;

   task equipo3 is
   end equipo3;
   task body equipo3 is
      ya_entro: Boolean_Array := (1 .. 3 => False);
      prox: Integer;
   begin
      while not (ya_entro(1) and ya_entro(2) and ya_entro(3)) loop
         sala.entrarSala;
         Put_Line ("Equipo 3 entra a la sala de espera");

         prox := Num_Aleatorio(1, 3);
         while ya_entro(prox) = True loop
            prox := Num_Aleatorio(1, 3);
         end loop;

         if prox = 1 then
            mesa1.pedir;
            sala.salirSala;
            Put_Line ("Equipo 3 ingresa a la mesa 1");
            delay 3.0;
            Put_Line ("Equipo 3 se va de la mesa 1");
            ya_entro(1) := True;
            mesa1.retirarse;
         elsif prox = 2 then
            mesa2.pedir;
            sala.salirSala;
            Put_Line ("Equipo 3 ingresa a la mesa 2");
            delay 3.0;
            Put_Line ("Equipo 3 se va de la mesa 2");
            ya_entro(2) := True;
            mesa2.retirarse;
         elsif prox = 3 then
            mesa3.pedir;
            sala.salirSala;
            Put_Line ("Equipo 3 ingresa a la mesa 3");
            delay 3.0;
            Put_Line ("Equipo 3 se va de la mesa 3");
            ya_entro(3) := True;
            mesa3.retirarse;
         end if;
      end loop;
   end equipo3;

   task equipo4 is
   end equipo4;
   task body equipo4 is
      ya_entro: Boolean_Array := (1 .. 3 => False);
      prox: Integer;
   begin
      while not (ya_entro(1) and ya_entro(2) and ya_entro(3)) loop
         sala.entrarSala;
         Put_Line ("Equipo 4 entra a la sala de espera");

         prox := Num_Aleatorio(1, 3);
         while ya_entro(prox) = True loop
            prox := Num_Aleatorio(1, 3);
         end loop;

         if prox = 1 then
            mesa1.pedir;
            sala.salirSala;
            Put_Line ("Equipo 4 ingresa a la mesa 1");
            delay 3.0;
            Put_Line ("Equipo 4 se va de la mesa 1");
            ya_entro(1) := True;
            mesa1.retirarse;
         elsif prox = 2 then
            mesa2.pedir;
            sala.salirSala;
            Put_Line ("Equipo 4 ingresa a la mesa 2");
            delay 3.0;
            Put_Line ("Equipo 4 se va de la mesa 2");
            ya_entro(2) := True;
            mesa2.retirarse;
         elsif prox = 3 then
            mesa3.pedir;
            sala.salirSala;
            Put_Line ("Equipo 4 ingresa a la mesa 3");
            delay 3.0;
            Put_Line ("Equipo 4 se va de la mesa 3");
            ya_entro(3) := True;
            mesa3.retirarse;
         end if;
      end loop;
   end equipo4;

   task equipo5 is
   end equipo5;
   task body equipo5 is
      ya_entro: Boolean_Array := (1 .. 3 => False);
      prox: Integer;
   begin
      while not (ya_entro(1) and ya_entro(2) and ya_entro(3)) loop
         sala.entrarSala;
         Put_Line ("Equipo 5 entra a la sala de espera");

         prox := Num_Aleatorio(1, 3);
         while ya_entro(prox) = True loop
            prox := Num_Aleatorio(1, 3);
         end loop;

         if prox = 1 then
            mesa1.pedir;
            sala.salirSala;
            Put_Line ("Equipo 5 ingresa a la mesa 1");
            delay 3.0;
            Put_Line ("Equipo 5 se va de la mesa 1");
            ya_entro(1) := True;
            mesa1.retirarse;
         elsif prox = 2 then
            mesa2.pedir;
            sala.salirSala;
            Put_Line ("Equipo 5 ingresa a la mesa 2");
            delay 3.0;
            Put_Line ("Equipo 5 se va de la mesa 2");
            ya_entro(2) := True;
            mesa2.retirarse;
         elsif prox = 3 then
            mesa3.pedir;
            sala.salirSala;
            Put_Line ("Equipo 5 ingresa a la mesa 3");
            delay 3.0;
            Put_Line ("Equipo 5 se va de la mesa 3");
            ya_entro(3) := True;
            mesa3.retirarse;
         end if;
      end loop;
   end equipo5;

   task equipo6 is
   end equipo6;
   task body equipo6 is
      ya_entro: Boolean_Array := (1 .. 3 => False);
      prox: Integer;
   begin
      while not (ya_entro(1) and ya_entro(2) and ya_entro(3)) loop
         sala.entrarSala;
         Put_Line ("Equipo 6 entra a la sala de espera");

         prox := Num_Aleatorio(1, 3);
         while ya_entro(prox) = True loop
            prox := Num_Aleatorio(1, 3);
         end loop;

         if prox = 1 then
            mesa1.pedir;
            sala.salirSala;
            Put_Line ("Equipo 6 ingresa a la mesa 1");
            delay 3.0;
            Put_Line ("Equipo 6 se va de la mesa 1");
            ya_entro(1) := True;
            mesa1.retirarse;
         elsif prox = 2 then
            mesa2.pedir;
            sala.salirSala;
            Put_Line ("Equipo 6 ingresa a la mesa 2");
            delay 3.0;
            Put_Line ("Equipo 6 se va de la mesa 2");
            ya_entro(2) := True;
            mesa2.retirarse;
         elsif prox = 3 then
            mesa3.pedir;
            sala.salirSala;
            Put_Line ("Equipo 6 ingresa a la mesa 3");
            delay 3.0;
            Put_Line ("Equipo 6 se va de la mesa 3");
            ya_entro(3) := True;
            mesa3.retirarse;
         end if;
      end loop;
   end equipo6;

   task equipo7 is
   end equipo7;
   task body equipo7 is
      ya_entro: Boolean_Array := (1 .. 3 => False);
      prox: Integer;
   begin
      while not (ya_entro(1) and ya_entro(2) and ya_entro(3)) loop
         sala.entrarSala;
         Put_Line ("Equipo 7 entra a la sala de espera");

         prox := Num_Aleatorio(1, 3);
         while ya_entro(prox) = True loop
            prox := Num_Aleatorio(1, 3);
         end loop;

         if prox = 1 then
            mesa1.pedir;
            sala.salirSala;
            Put_Line ("Equipo 7 ingresa a la mesa 1");
            delay 3.0;
            Put_Line ("Equipo 7 se va de la mesa 1");
            ya_entro(1) := True;
            mesa1.retirarse;
         elsif prox = 2 then
            mesa2.pedir;
            sala.salirSala;
            Put_Line ("Equipo 7 ingresa a la mesa 2");
            delay 3.0;
            Put_Line ("Equipo 7 se va de la mesa 2");
            ya_entro(2) := True;
            mesa2.retirarse;
         elsif prox = 3 then
            mesa3.pedir;
            sala.salirSala;
            Put_Line ("Equipo 7 ingresa a la mesa 3");
            delay 3.0;
            Put_Line ("Equipo 7 se va de la mesa 3");
            ya_entro(3) := True;
            mesa3.retirarse;
         end if;
      end loop;
   end equipo7;

begin
   null;
end Main;
