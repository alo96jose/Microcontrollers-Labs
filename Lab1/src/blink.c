#include <pic14/pic12f683.h> 
#include <stdio.h>
#include <stdlib.h>

typedef unsigned int word;
word __at 0x2007 __CONFIG = (_WDTE_OFF); // Desactiva el Watchdog Timer

void delay(unsigned int tiempo);
void bcd_convert(int num, int *bcd);
//int aleatorio();

unsigned int time = 100;
unsigned int lfsr = 0xACE1u;

void main(void)
{
    TRISIO = 0b00001000; //Poner todos los pines como salidas menos el pin3.
    GPIO = 0x00; //Poner pines en bajo menos el pin3.

    unsigned char i=0; // Contador
    unsigned int j=0, num_aleatorio, variable1=0, variable2=0, resultado=0;
    unsigned int variable_BCD[4];
    unsigned char hex_values[4];

    

    // Loop infinito para que bingo no termine.
    while( 1 )
    {
        // While espera que GP3=0. 
        // En este ciclo se produce el número aleatorio
        j++;
        if(j==100){
            num_aleatorio=99;
            j = 0;
        }
        else{
            num_aleatorio = j;
        }
        
        //for (unsigned int j = 0; j < 100; j++)
        //{
          //  num_aleatorio=j;
        //}

        if(GP3)
        {
            // Código a ejecutar cuando GP3=1.
            i++; // Aumento contador de pulsos en 1.

            if (num_aleatorio < 10)
            {
                variable1 = 0;
                variable2 = num_aleatorio;
            }
            else
            {
                // Extracting the first and second digits
                variable1 = num_aleatorio / 10;  // Get the first digit
                variable2 = num_aleatorio % 10;  // Get the second digit
            }

            // Número de 2 dígitos que esta entre [00,99]
            resultado = (variable1 * 10 + variable2) % 100;

            // Guardo número para no repetir (PENDIENTE)

            // Se convierten enteros variable 1 a código BCD
            bcd_convert(variable1, variable_BCD);

            // Valores en variable1_BCD pasan a hexadecimal
            for (unsigned char j = 0; j < 4; ++j) {
            hex_values[j] = (variable_BCD[j] == 0) ? 0x00 : 0xFF;
            }

            // Enciendo display 1 (der)
            GP5 = 0x00;

            // Entrego en pines el código en BCD de variable1
            GP0 = hex_values[0];
            GP1 = hex_values[1];
            GP2 = hex_values[2];
            GP4 = hex_values[3];

            // Se convierten enteros de variable 2 a código BCD
            bcd_convert(variable2, variable_BCD);

            // Tiempo espera
            delay(time);

            // Valores en variable2_BCD pasan a hexadecimal
            for (unsigned char j = 0; j < 4; ++j) {
            hex_values[j] = (variable_BCD[j] == 0) ? 0x00 : 0xFF;
            }

            // Enciendo display 2 (izq)
            GP5 = 0xFF;

            // Entrego en pines el código en BCD de variable2
            GP0 = hex_values[0];
            GP1 = hex_values[1];
            GP2 = hex_values[2];
            GP4 = hex_values[3];

            // Tiempo espera
            delay(time);

            // GP3 vuelve a ser 0
            //GP3 = 0x00;

        }
        
    }

}

void delay(unsigned int tiempo)
{
    unsigned int i;
    unsigned int j;
    
    for(i=0;i<tiempo;i++)
	  for(j=0;j<1275;j++);
}

void bcd_convert(int num, int *bcd) {
    bcd[0] = num / 8;
    bcd[1] = (num % 8) / 4;
    bcd[2] = (num % 4) / 2;
    bcd[3] = num % 2;
}

/*** 
int aleatorio(){
    unsigned bit;

    bit = ((lfsr >> 0) ^ (lfsr >> 2) ^ (lfsr >> 3) ^ (lfsr >> 5)) & 1;
    lfsr = (lfsr >> 1) | (bit << 15);
    return lfsr % 100; // Generate a random number between 0 and 99
}

***/
