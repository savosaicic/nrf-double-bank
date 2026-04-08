#include <zephyr/kernel.h>
#include <zephyr/sys/printk.h>

int main(void)
{
  printk("hello from bank0\n");
  while (1) {
    k_sleep(K_FOREVER);
  }
  return 0;
}
