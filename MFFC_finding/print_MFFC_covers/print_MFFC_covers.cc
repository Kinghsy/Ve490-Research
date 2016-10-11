


#include "print_MFFC_covers.h"

int print_MFFC_covers(string &infile)
{
	DdManager *ddmanager = NULL;		/* pointer to DD manager */
	//NtrOptions *option;	/* options */
	//option = mainInit();
	
	//string infile = "test/subckt1.blif"; 
	//string infile = "c432.blif";
    	FILE *fp;
    	fp = fopen(infile.c_str(), "r");
    	BnetNetwork *net = Bnet_ReadNetwork(fp);

	/* Initialize manager. We start with 0 variables, because
	** Ntr_buildDDs will create new variables rather than using
	** whatever already exists.
	*/
	//dd = startCudd(option,net->ninputs);
	//if (dd == NULL) { exit(2); }

	
	
	ddmanager = Cudd_Init(0, 0, CUDD_UNIQUE_SLOTS, CUDD_CACHE_SLOTS, 0);
 	if (ddmanager == NULL) return -1;      
    	cudd_build_v2(net, &ddmanager, infile.c_str(), BNET_GLOBAL_DD);
    
	//cout << net.
	//Bnet_PrintNetwork(net);

	// find the DdNode of the output node 
	BnetNode *auxnd;
	st_lookup(net->hash,net->outputs[0],&auxnd);
	DdNode *ddnode_pt = auxnd->dd;
	int result = Cudd_PrintMinterm(ddmanager, ddnode_pt);

/*
	BnetTabline *truthTable_pt;
	truthTable_pt = auxnd->f;
	string truthTable_string = truthTable_pt->values;
	cout << truthTable_string << endl;
*/

	//int result = Ntr_buildDDs(net, dd, option, NULL);
	//if (result == 0) { exit(2); }
	Bnet_FreeNetwork_Bdd(net, ddmanager);
	Cudd_Quit(ddmanager);

}



