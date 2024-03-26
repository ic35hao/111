// See LICENSE for license details.
#include <stdint.h>


#include <platform.h>

#include "common.h"

#define DEBUG
#include "kprintf.h"

int main(void)
{

  //uint32_t * ddr_ptr;
  //unsigned long test;
  //test = 0x5a5a;
  REG32(uart, UART_REG_TXCTRL) = UART_TXEN;  // donot delete
//   ddr_ptr = (void *)(0x81001000UL);
//   for(int i = 0 ; i < 0x1000; i++){
//     *(ddr_ptr + i) = 0x81001000 + i;
//   }
	kprintf("Hello RISC-V! @ core: %x", read_csr(mhartid));
	if (1){
		kprintf("PASS");
	}
	else{
		kprintf("FAIL");
	}

	kprintf(SHUTDOWN_FLAG_STR);  // donnot delete

	return 0;
}
