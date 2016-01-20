#include <app_cfg.h>
#include <bsp.h>
#include <os.h>

static OS_TCB		AppTaskStartTCB;
static CPU_STK		AppTaskStartStk[APP_TASK_START_STK_SIZE];
