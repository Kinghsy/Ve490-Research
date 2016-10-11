#ifndef _CUDD_BUILD_V2_H
#define _CUDD_BUILD_V2_H

#include "/home/wangchen/Research/cudd/cudd-2.5.0/cudd/cudd.h"
#include "/home/wangchen/Research/cudd/cudd-2.5.0/cudd/cuddInt.h"
#include "head/bnet.h"


void cudd_build_v2(BnetNetwork *net, DdManager **dd, const char *filename, int params);

#endif
