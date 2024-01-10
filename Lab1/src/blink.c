#include <pic14/pic12f683.h> 
#include <stdio.h>
#include <stdlib.h>

typedef unsigned int word;
word __at 0x2007 __CONFIG = (_WDTE_OFF); // Desactiva el Watchdog TImer

void delay(unsigned int tiempo);
void delay_final(void);
void bcd_convert(int num, int *bcd);
void processBCD(const int variable1_BCD[4], unsigned char hex_values[4]);

unsigned int time = 100;
unsigned int short_time = 30;

void main(void)
{
    TRISIO = 0b00001000; //Poner todos los pines como salidas menos el pin3.
    GPIO = 0b00001000; //Poner pines en bajo menos el pin3.

    unsigned char i=0; // Contador
    int num_aleatorio=0, variable1=0, variable2=0, resultado=0;
    int variable1_BCD[4], variable2_BCD[4];
    unsigned char hex_values[4];

    // Loop infinito para que bingo no termine.
    while( 1 )
    {
        // While espera que GP3=0. 
        // En este ciclo se produce el número aleatorio
        for (int j = 0; j < 100; j++)
        {
            num_aleatorio=j;
        }

        if( GP3 == 0)
        {
            // Código a ejecutar cuando GP3=0.
            i++; // Aumento contador en 1.
            
            if (num_aleatorio < 10)
            {
                variable1 = 0;
                variable2 = num_aleatorio;
            }
            else
            {
                // Extracting the first and second digits
                int variable1 = num_aleatorio / 10;  // Get the first digit
                int variable2 = num_aleatorio % 10;  // Get the second digit
            }
        
            // Número de 2 dígitos que esta entre [00,99]
            resultado = (variable1 * 10 + variable2) % 100;

            // Guardo número para no repetir (PENDIENTE)

            // Se convierten enteros a código BCD
            bcd_convert(variable1, variable1_BCD);
            bcd_convert(variable2, variable2_BCD);

            // Valores en variable1_BCD pasan a hexadecimal
            processBCD(variable1_BCD, hex_values);

            // Enciendo display 1 (der)
            GP5 = 0x00;

            // Entrego en pines el código en BCD de variable1´
            GP0 = hex_values[0];
            GP1 = hex_values[1];
            GP2 = hex_values[2];
            GP4 = hex_values[3];

            // Tiempo espera
            delay(time);

            // Valores en variable2_BCD pasan a hexadecimal
            processBCD(variable2_BCD, hex_values);

            // Enciendo display 2 (izq)
            GP5 = 0xFF;

            // Entrego en pines el código en BCD de variable2
            GP0 = hex_values[0];
            GP1 = hex_values[1];
            GP2 = hex_values[2];
            GP4 = hex_values[3];

            // Tiempo espera
            delay(time);

            // Contar las veces que GP3 se torna 0. Cuando llege a 10 veces, desplegar en los displays 99.
            if (i==10)
            {
                // Función 99 resalta 3 veces
                delay_final(); // 1
                delay_final(); // 2
                delay_final(); // 3

                // Vaciar arreglo con números repetidos

                // Empezar contador
                i=0;
            }

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

void delay_final()
{
    // Tiempo espera para que aparesca primer 99
    delay(time);

    // Enciendo display 1 (der)
    GP5 = 0x00;

    // Poner en pines el número 9. Primer dígito de 99.
    GP0 = 0x01;
    GP1 = 0x00;
    GP2 = 0x00;
    GP4 = 0x00;

    // Tiempo de espera corto para segundo dígito de 99.
    // delay(short_time);

    // Enciendo display 2 (izq)
    GP5 = 0xFF;

    // Poner en pines el número 9. segundo dígito de 99.
    GP0 = 0x01;
    GP1 = 0x00;
    GP2 = 0x00;
    GP4 = 0x00;

    // Tiempo espera para ver 99 en acción
    delay(time);

    // Apago display 2
    GP0 = 0x00;
    GP1 = 0x00;
    GP2 = 0x00;
    GP4 = 0x00;

    // Apago display 1
    GP5 = 0x00;
    GP0 = 0x00;
    GP1 = 0x00;
    GP2 = 0x00;
    GP4 = 0x00;

    // Tiempo espera
    delay(time);
}

void bcd_convert(int num, int *bcd) {
    bcd[0] = num / 8;
    bcd[1] = (num % 8) / 4;
    bcd[2] = (num % 4) / 2;
    bcd[3] = num % 2;
}

void processBCD(const int variable1_BCD[4], unsigned char hex_values[4]) {
    for (int i = 0; i < 4; ++i) {
        hex_values[i] = (variable1_BCD[i] == 0) ? 0x00 : 0xFF;
    }
}