
1. Finn AVR include path:
    * På Linux: `/usr/lib/avr/include` (sannsynligvis)
    * På Windows: varierer, men jeg brukte `C:\\Program Files (x86)\\Atmel\\Studio\\7.0\\toolchain\\avr8\\avr8-gnu-toolchain\\avr\\include`

2. Legg til i `c_cpp_properties.json` under `"includePath"`. 

3. Legg til i `c_cpp_properties.json` under `"defines"` hvilken mikrokontroller du bruker. Her er det å gjette litt og se i `io.h`. For ATmega162 er rett define `__AVR_ATmega162__`.

4. Hvis C/C++ Clang Command Adapter er installert, må den disables i dette workspacet. Jeg vet ikke hvorfor. 

