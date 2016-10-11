#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <cstdlib>
#include <climits>
#include <vector>
#include <map>
#include <cmath>
#include <cassert>
#include <ctime>
#include <sys/timeb.h>
#include "head/queue.h"
#include "head/basics.h"
#include "head/bnet.h"


using namespace std;

void print_truthTable(string &outfile){

	DdNode* x1 = Cudd_bddIthVar(manager, 0);
	DdNode* x2 = Cudd_bddIthVar(manager, 1);

	DdNode* restrictBy;
	restrictBy = Cudd_bddAnd(manager,x1,x2,x3,x4,x5);
	Cudd_Ref(restrictBy);

	DdNode* out_bit;
	out_bit = Cudd_bddRestrict(manager, out_bit, restrictBy);
	Cudd_Ref(out_bit);


	printf("x1 = 1, x2 = 0: outbit = %d", 1 - Cudd_IsComplement(out_bit));

	Cudd_RecursiveDeref(manager, out_bit);
}






/*
DdNode* restrictBy;
restrictBy = Cudd_bddAnd(manager, x1, Cudd_Not(x2));
Cudd_Ref(restrictBy);
DdNode* testSum;
testSum = Cudd_bddRestrict(manager, sum, restrictBy);
Cudd_Ref(testSum);
DdNode* testCarry;
testCarry = Cudd_bddRestrict(manager, carry, restrictBy);
Cudd_Ref(testCarry);
printf("x1 = 1, x2 = 0: sum = %d, carry = %d\n",1 - Cudd_IsComplement(testSum),1 - Cudd_IsComplement(testCarry));

Cudd_RecursiveDeref(manager, restrictBy);
Cudd_RecursiveDeref(manager, testSum);
Cudd_RecursiveDeref(manager, testCarry);
*/












