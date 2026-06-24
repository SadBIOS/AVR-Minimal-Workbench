#include <avr/io.h>
#include <util/delay.h>

int main(void) {
    DDRB = 0x20;

    while (1) {
        PORTB = 0x20;
        _delay_ms(100);
        PORTB = 0x00;
        _delay_ms(100);
    }

    return 0;
}